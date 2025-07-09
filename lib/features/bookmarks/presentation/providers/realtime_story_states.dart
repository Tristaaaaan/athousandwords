import 'dart:async';

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../domain/realtime_story_repo.dart';

class RealTimeBookmarkStoryState extends ChangeNotifier {
  final RealTimeStoryBookMarkRepository _storyRepo;
  late final ScrollController homeScrollController;

  List<BookmarkData> bookmarks = [];
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
      (snapshot) {
        final newBookmarks = snapshot.docs.map((doc) => doc.data()).toList();

        for (final bookmark in newBookmarks) {
          final index = bookmarks.indexWhere(
            (b) => b.storyId == bookmark.storyId,
          );
          if (index == -1) {
            bookmarks.add(bookmark);
          } else {
            bookmarks[index] = bookmark;
          }
        }

        // Sort by bookmarkedAt descending (newest first)
        bookmarks.sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));

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

    final fetchedStories = await _storyRepo.fetchBookmarks(limitTo);
    // Note: bookmarks list holds BookmarkData, fetchedStories returns StoryData,
    // So only update hasNextStories here, keep bookmarks list as is (managed by stream)
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

    final fetchedStories = await _storyRepo.fetchBookmarks(limitTo);
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
