import 'dart:async';

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/appmodels/story.dart';
import '../../domain/realtime_story_repo.dart';

class BookmarkWithStory {
  final BookmarkData bookmark;
  final StoryData story;

  BookmarkWithStory({required this.bookmark, required this.story});
}

class RealTimeBookmarkStoryState extends ChangeNotifier {
  final RealTimeStoryBookMarkRepository _storyRepo;
  late final ScrollController homeScrollController;

  List<BookmarkWithStory> bookmarkWithStories = [];
  Set<String> loadedStoryIds = {};

  bool isFetchingStories = false;
  bool hasNextStories = true;
  bool hideFAB = false;
  final int limitTo = 20;

  StreamSubscription<QuerySnapshot<BookmarkData>>? _bookmarksSubscription;
  bool _loading = false;

  RealTimeBookmarkStoryState(this._storyRepo) {
    homeScrollController = ScrollController();
    homeScrollController.addListener(_listenToHomeScroll);
    _setupRealtimeListener();
    _loadInitialBookmarks();
  }

  void _setupRealtimeListener() {
    _bookmarksSubscription = _storyRepo.bookmarksStream.listen(
      (snapshot) async {
        final newBookmarks = snapshot.docs.map((doc) => doc.data()).toList();
        final storyIds = newBookmarks.map((b) => b.storyId).toSet();

        final storyFutures = storyIds.map((id) => _storyRepo.doc(id).get());
        final storySnapshots = await Future.wait(storyFutures);

        final updatedPairs = <BookmarkWithStory>[];

        for (int i = 0; i < newBookmarks.length; i++) {
          final storySnap = storySnapshots.elementAt(i);
          if (storySnap.exists) {
            final story = storySnap.data()!;
            updatedPairs.add(
              BookmarkWithStory(bookmark: newBookmarks[i], story: story),
            );
          }
        }

        bookmarkWithStories
          ..clear()
          ..addAll(updatedPairs);

        loadedStoryIds
          ..clear()
          ..addAll(updatedPairs.map((e) => e.bookmark.storyId));

        notifyListeners();
      },
      onError: (error) {
        debugPrint('Error in bookmarks stream: $error');
      },
    );
  }

  Future<void> _loadInitialBookmarks() async {
    if (_loading) return;
    _loading = true;
    isFetchingStories = true;
    notifyListeners();

    final newPairs = await _storyRepo.fetchBookmarks(limitTo, loadedStoryIds);
    bookmarkWithStories.addAll(newPairs);
    loadedStoryIds.addAll(newPairs.map((e) => e.bookmark.storyId));
    hasNextStories = _storyRepo.hasNextStories;

    isFetchingStories = false;
    _loading = false;
    notifyListeners();
  }

  Future<void> _loadNextBatchBookmarks() async {
    if (_loading || !hasNextStories) return;

    _loading = true;
    isFetchingStories = true;
    notifyListeners();

    final newPairs = await _storyRepo.fetchBookmarks(limitTo, loadedStoryIds);
    bookmarkWithStories.addAll(newPairs);
    loadedStoryIds.addAll(newPairs.map((e) => e.bookmark.storyId));
    hasNextStories = _storyRepo.hasNextStories;

    isFetchingStories = false;
    _loading = false;
    notifyListeners();
  }

  void _listenToHomeScroll() {
    final position = homeScrollController.position;

    if (position.maxScrollExtent < 200) return;

    if (position.pixels >= position.maxScrollExtent - 150 && hasNextStories) {
      _loadNextBatchBookmarks();
    }

    _handleFABVisibility();
  }

  void _handleFABVisibility() {
    final direction = homeScrollController.position.userScrollDirection;

    if (direction == ScrollDirection.forward && hideFAB) {
      hideFAB = false;
      notifyListeners();
    } else if (direction == ScrollDirection.reverse && !hideFAB) {
      hideFAB = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _bookmarksSubscription?.cancel();
    homeScrollController.dispose();
    super.dispose();
  }
}
