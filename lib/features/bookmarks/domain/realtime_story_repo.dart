import 'dart:developer' as developer;

import 'package:athousandwords/core/appmodels/bookmark.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/appmodels/story.dart';
import '../presentation/providers/realtime_story_states.dart';

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

  Stream<QuerySnapshot<BookmarkData>> get bookmarksStream {
    return _firestoreUserBookmarks
        .orderBy('bookmarkedAt', descending: true)
        .snapshots();
  }

  Future<List<BookmarkWithStory>> fetchBookmarks([
    int limitTo = 20,
    Set<String>? excludeIds,
  ]) async {
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

        final newBookmarks = snapshot.docs
            .map((doc) => doc.data())
            .where((b) => !(excludeIds?.contains(b.storyId) ?? false))
            .toList();

        final storyFutures = newBookmarks.map(
          (b) => _storiesCollection.doc(b.storyId).get(),
        );
        final storySnapshots = await Future.wait(storyFutures);

        if (snapshot.docs.length < limitTo) {
          hasNextStories = false;
        }

        final bookmarkWithStories = <BookmarkWithStory>[];
        for (int i = 0; i < newBookmarks.length; i++) {
          if (storySnapshots[i].exists) {
            bookmarkWithStories.add(
              BookmarkWithStory(
                bookmark: newBookmarks[i],
                story: storySnapshots[i].data()!,
              ),
            );
          }
        }

        return bookmarkWithStories;
      } else {
        hasNextStories = false;
      }
    } catch (e) {
      developer.log('Error fetching bookmarks: $e');
    }

    return [];
  }

  DocumentReference<StoryData> doc(String storyId) {
    return _storiesCollection.doc(storyId);
  }
}
