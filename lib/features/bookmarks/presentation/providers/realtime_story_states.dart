import 'dart:async';

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/appmodels/story.dart';
import '../../domain/realtime_story_repo.dart';

// Create a combined model to hold both bookmark and story data

class RealTimeBookmarkStoryState extends ChangeNotifier {
  final RealTimeStoryBookMarkRepository _storyRepo;
  late final ScrollController homeScrollController;

  List<BookmarkWithStory> bookmarks = [];
  bool isFetchingStories = false;
  bool hasNextStories = true;
  bool hideFAB = false;
  final int limitTo = 20;

  StreamSubscription<QuerySnapshot<BookmarkData>>? _bookmarksSubscription;
  final Map<String, StreamSubscription<DocumentSnapshot<StoryData>>>
  _storySubscriptions = {};
  bool _loading = false;
  bool _isInitialized = false;

  RealTimeBookmarkStoryState(this._storyRepo) {
    homeScrollController = ScrollController();
    homeScrollController.addListener(_listenToHomeScroll);
    _setupRealtimeListener();
    _loadInitialBookmarks();
  }

  void _setupRealtimeListener() {
    _bookmarksSubscription = _storyRepo.bookmarksStream.listen(
      (snapshot) {
        _handleBookmarkChanges(snapshot);
      },
      onError: (error) {
        debugPrint('Error in bookmarks stream: $error');
      },
    );
  }

  void _handleBookmarkChanges(QuerySnapshot<BookmarkData> snapshot) {
    final newBookmarks = snapshot.docs.map((doc) => doc.data()).toList();
    final newBookmarkIds = newBookmarks.map((b) => b.storyId).toSet();

    // Remove bookmarks that are no longer in the new snapshot
    final removedBookmarks = bookmarks
        .where((bws) => !newBookmarkIds.contains(bws.bookmark.storyId))
        .toList();

    // Cancel story subscriptions for removed bookmarks
    for (final removed in removedBookmarks) {
      _storySubscriptions[removed.bookmark.storyId]?.cancel();
      _storySubscriptions.remove(removed.bookmark.storyId);
    }

    // Remove from bookmarks list
    bookmarks.removeWhere(
      (bws) => !newBookmarkIds.contains(bws.bookmark.storyId),
    );

    // Add new bookmarks and set up story subscriptions
    for (final bookmark in newBookmarks) {
      final existingIndex = bookmarks.indexWhere(
        (bws) => bws.bookmark.storyId == bookmark.storyId,
      );

      if (existingIndex == -1) {
        // New bookmark - fetch story data and add subscription
        _addNewBookmark(bookmark);
      } else {
        // Update existing bookmark data
        bookmarks[existingIndex] = BookmarkWithStory(
          bookmark: bookmark,
          story: bookmarks[existingIndex].story,
        );
      }
    }

    // Sort by bookmarkedAt descending (newest first)
    bookmarks.sort(
      (a, b) => b.bookmark.bookmarkedAt.compareTo(a.bookmark.bookmarkedAt),
    );

    notifyListeners();
  }

  void _addNewBookmark(BookmarkData bookmark) async {
    final bookmarkStory = await _storyRepo.fetchStoryForBookmark(bookmark);
    if (bookmarkStory != null) {
      bookmarks.add(bookmarkStory);
      _setupStorySubscription(bookmarkStory.story.storyId!);

      // Sort and notify after adding
      bookmarks.sort(
        (a, b) => b.bookmark.bookmarkedAt.compareTo(a.bookmark.bookmarkedAt),
      );
      notifyListeners();
    }
  }

  void _setupStorySubscription(String storyId) {
    // Cancel existing subscription if any
    _storySubscriptions[storyId]?.cancel();

    // Set up new subscription
    _storySubscriptions[storyId] = _storyRepo
        .getStoryStream(storyId)
        .listen(
          (storySnapshot) {
            if (storySnapshot.exists) {
              final updatedStory = storySnapshot.data()!;

              // Update the story in our bookmarks list
              final index = bookmarks.indexWhere(
                (bws) => bws.story.storyId == storyId,
              );

              if (index != -1) {
                bookmarks[index] = BookmarkWithStory(
                  bookmark: bookmarks[index].bookmark,
                  story: updatedStory,
                );
                notifyListeners();
              }
            }
          },
          onError: (error) {
            debugPrint('Error in story stream for $storyId: $error');
          },
        );
  }

  Future<void> _loadInitialBookmarks() async {
    if (_loading || _isInitialized) return;
    _loading = true;
    _isInitialized = true;
    isFetchingStories = true;
    notifyListeners();

    final fetchedBookmarks = await _storyRepo.fetchBookmarks(limitTo);

    // Clear existing data to prevent duplication
    bookmarks.clear();
    _cancelAllStorySubscriptions();

    bookmarks.addAll(fetchedBookmarks);
    hasNextStories = _storyRepo.hasNextStories;

    // Set up story subscriptions for all loaded bookmarks
    for (final bookmarkWithStory in bookmarks) {
      _setupStorySubscription(bookmarkWithStory.story.storyId!);
    }

    isFetchingStories = false;
    _loading = false;
    notifyListeners();
  }

  Future<void> _loadNextBatchBookmarks() async {
    if (_loading || !hasNextStories) return;

    _loading = true;
    isFetchingStories = true;
    notifyListeners();

    final fetchedBookmarks = await _storyRepo.fetchBookmarks(limitTo);

    // Add new bookmarks without clearing existing ones
    for (final newBookmark in fetchedBookmarks) {
      final existingIndex = bookmarks.indexWhere(
        (bws) => bws.bookmark.storyId == newBookmark.bookmark.storyId,
      );

      if (existingIndex == -1) {
        bookmarks.add(newBookmark);
        _setupStorySubscription(newBookmark.story.storyId!);
      }
    }

    hasNextStories = _storyRepo.hasNextStories;

    isFetchingStories = false;
    _loading = false;
    notifyListeners();
  }

  void _cancelAllStorySubscriptions() {
    for (final subscription in _storySubscriptions.values) {
      subscription.cancel();
    }
    _storySubscriptions.clear();
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
    _cancelAllStorySubscriptions();
    homeScrollController.dispose();
    super.dispose();
  }
}
