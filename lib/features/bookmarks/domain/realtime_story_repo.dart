import 'dart:developer' as developer;

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/story.dart';

// Create a combined model to hold both bookmark and story data
class BookmarkWithStory {
  final BookmarkData bookmark;
  final StoryData story;

  BookmarkWithStory({required this.bookmark, required this.story});
}

class RealTimeStoryBookMarkRepository {
  final String userId;

  DocumentSnapshot<BookmarkData>? lastBookmarkDoc;
  bool hasNextStories = true;

  late final CollectionReference<BookmarkData> _firestoreUserBookmarks =
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection("bookmarks")
          .withConverter<BookmarkData>(
            fromFirestore: (snapshot, _) =>
                BookmarkData.fromJson(snapshot.data()!),
            toFirestore: (bookmark, _) => bookmark.toJson(),
          );

  final CollectionReference<StoryData> _storiesCollection = FirebaseFirestore
      .instance
      .collection('stories')
      .withConverter<StoryData>(
        fromFirestore: (snapshot, _) => StoryData.fromJson(snapshot.data()!),
        toFirestore: (story, _) => story.toJson(),
      );

  RealTimeStoryBookMarkRepository({required this.userId});

  // Stream of bookmark docs ordered by bookmarkedAt
  Stream<QuerySnapshot<BookmarkData>> get bookmarksStream {
    return _firestoreUserBookmarks
        .orderBy('bookmarkedAt', descending: true)
        .snapshots();
  }

  // Returns list of BookmarkWithStory objects
  Future<List<BookmarkWithStory>> fetchBookmarks([int limitTo = 20]) async {
    try {
      Query<BookmarkData> query = _firestoreUserBookmarks
          .orderBy('bookmarkedAt', descending: true)
          .limit(limitTo);

      if (lastBookmarkDoc != null) {
        query = query.startAfterDocument(lastBookmarkDoc!);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        lastBookmarkDoc = snapshot.docs.last;

        final bookmarkWithStoryList = <BookmarkWithStory>[];

        // Fetch story documents for each bookmark
        for (final bookmarkDoc in snapshot.docs) {
          final bookmark = bookmarkDoc.data();
          final storyDoc = await _storiesCollection.doc(bookmark.storyId).get();

          if (storyDoc.exists) {
            bookmarkWithStoryList.add(
              BookmarkWithStory(bookmark: bookmark, story: storyDoc.data()!),
            );
          }
        }

        if (snapshot.docs.length < limitTo) {
          hasNextStories = false;
        }

        return bookmarkWithStoryList;
      } else {
        hasNextStories = false;
      }
    } catch (e) {
      developer.log('Error fetching bookmarks: $e');
    }

    return [];
  }

  // Helper method to fetch story data for a single bookmark
  Future<BookmarkWithStory?> fetchStoryForBookmark(
    BookmarkData bookmark,
  ) async {
    try {
      final storyDoc = await _storiesCollection.doc(bookmark.storyId).get();

      if (storyDoc.exists) {
        return BookmarkWithStory(bookmark: bookmark, story: storyDoc.data()!);
      }
    } catch (e) {
      developer.log('Error fetching story for bookmark: $e');
    }
    return null;
  }

  // Helper to get story document reference by storyId
  DocumentReference<StoryData> doc(String storyId) {
    return _storiesCollection.doc(storyId);
  }

  // Get real-time story updates for a specific story
  Stream<DocumentSnapshot<StoryData>> getStoryStream(String storyId) {
    return _storiesCollection.doc(storyId).snapshots();
  }
}
