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

        // Create a set of current story IDs for comparison
        final newBookmarkIds = newBookmarks.map((b) => b.storyId).toSet();

        // Remove bookmarks that are no longer in the new snapshot
        bookmarks.removeWhere(
          (bookmark) => !newBookmarkIds.contains(bookmark.storyId),
        );

        // Add or update remaining bookmarks
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

  // // Alternative version using DocumentChanges for more efficient updates
  // void _setupRealtimeListenerAlternative() {
  //   _bookmarksSubscription = _storyRepo.bookmarksStream.listen(
  //     (snapshot) {
  //       for (final change in snapshot.docChanges) {
  //         switch (change.type) {
  //           case DocumentChangeType.added:
  //             bookmarks.add(change.doc.data()!);
  //             break;
  //           case DocumentChangeType.modified:
  //             final index = bookmarks.indexWhere(
  //               (b) => b.storyId == change.doc.data()!.storyId,
  //             );
  //             if (index != -1) {
  //               bookmarks[index] = change.doc.data()!;
  //             }
  //             break;
  //           case DocumentChangeType.removed:
  //             bookmarks.removeWhere(
  //               (b) => b.storyId == change.doc.data()!.storyId,
  //             );
  //             break;
  //         }
  //       }

  //       // Sort by bookmarkedAt descending (newest first)
  //       bookmarks.sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));

  //       notifyListeners();
  //     },
  //     onError: (error) {
  //       debugPrint('Error in bookmarks stream: $error');
  //     },
  //   );
  // }

  Future<void> _loadInitialBookmarks() async {
    if (_loading) return;
    _loading = true;
    isFetchingStories = true;
    notifyListeners();

    await _storyRepo.fetchBookmarks(limitTo);
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
