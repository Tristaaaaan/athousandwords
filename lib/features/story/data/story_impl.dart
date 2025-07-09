import 'dart:developer' as developer;

import 'package:athousandwords/core/appmodels/story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import '../domain/story_repo.dart';

class StoryRepositoryImpl extends StoryRepository {
  final FirebaseFirestore _firestore;

  StoryRepositoryImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createStory(StoryData storyData) async {
    try {
      final docRef = _firestore.collection("stories").doc();
      await docRef.set(storyData.toMap());
    } catch (e, st) {
      developer.log(
        'Error creating story',
        name: 'StoryRepositoryImpl',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Stream<StoryData> getStoryStream() {
    return _firestore.collection("stories").snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        throw Exception("No stories found");
      }

      final doc = snapshot.docs.first;
      final data = StoryData.fromJson(doc.data());
      return data.copyWith(storyId: doc.id);
    });
  }

  @override
  Future<void> addBookmark(String storyId, String userId) async {
    final storyRef = _firestore.collection("stories").doc(storyId);
    final userBookmarkRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("bookmarks")
        .doc(storyId);

    await _firestore.runTransaction((transaction) async {
      final userBookmarkSnap = await transaction.get(userBookmarkRef);
      if (!userBookmarkSnap.exists) {
        transaction.set(userBookmarkRef, {
          "storyId": storyId,
          "bookmarkedAt": FieldValue.serverTimestamp(),
        });
        transaction.update(storyRef, {"bookmarks": FieldValue.increment(1)});
      }
    });
  }

  @override
  Future<void> removeBookmark(String storyId, String userId) async {
    final storyRef = _firestore.collection("stories").doc(storyId);
    final userBookmarkRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("bookmarks")
        .doc(storyId);

    await _firestore.runTransaction((transaction) async {
      final userBookmarkSnap = await transaction.get(userBookmarkRef);
      if (userBookmarkSnap.exists) {
        transaction.delete(userBookmarkRef);
        transaction.update(storyRef, {"bookmarks": FieldValue.increment(-1)});
      }
    });
  }
}

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryImpl();
});
