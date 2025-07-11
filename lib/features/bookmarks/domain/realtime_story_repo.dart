import 'dart:developer' as developer;

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/story.dart';

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

  // Returns list of StoryData documents from bookmark storyIds
  Future<List<StoryData>> fetchBookmarks([int limitTo = 20]) async {
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

        final ids = snapshot.docs
            .map((doc) => doc.data().storyId)
            .whereType<String>()
            .toList();

        // Fetch story documents for each storyId
        final storyFutures = ids.map((id) => _storiesCollection.doc(id).get());
        final storySnapshots = await Future.wait(storyFutures);

        if (snapshot.docs.length < limitTo) {
          hasNextStories = false;
        }

        return storySnapshots
            .where((snap) => snap.exists)
            .map((snap) => snap.data()!)
            .toList();
      } else {
        hasNextStories = false;
      }
    } catch (e) {
      developer.log('Error fetching bookmarks: $e');
    }

    return [];
  }

  // Helper to get story document reference by storyId
  DocumentReference<StoryData> doc(String storyId) {
    return _storiesCollection.doc(storyId);
  }
}
