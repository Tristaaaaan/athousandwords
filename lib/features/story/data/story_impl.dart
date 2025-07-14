import 'dart:developer' as developer;
import 'dart:math';

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
      final updatedStory = storyData.copyWith(storyId: docRef.id);
      await docRef.set(updatedStory.toMap());
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
  Future<StoryData> getStory({String storyId = ""}) async {
    try {
      final snapshot = await _firestore.collection("stories").get();

      final allDocs = snapshot.docs;

      // Handle no stories case
      if (allDocs.isEmpty) {
        throw Exception("No stories found.");
      }

      // Filter out the current storyId if provided
      final filteredDocs = storyId.isNotEmpty
          ? allDocs.where((doc) => doc.id != storyId).toList()
          : allDocs;

      // If filtering left no documents (e.g., only one story), fallback to original list
      final finalDocs = filteredDocs.isNotEmpty ? filteredDocs : allDocs;

      // Get a random document
      final randomDoc = finalDocs[Random().nextInt(finalDocs.length)];

      return StoryData.fromJson(randomDoc.data());
    } catch (e, st) {
      developer.log(
        'Error getting story',
        name: 'StoryRepositoryImpl',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
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

  @override
  Future<bool> isBookmarked(String storyId, String userId) async {
    final userBookmarkRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("bookmarks")
        .doc(storyId);
    final userBookmarkSnap = await userBookmarkRef.get();
    return userBookmarkSnap.exists;
  }

  @override
  Future<void> addLike(String storyId, String userId) async {
    final storyRef = _firestore.collection("stories").doc(storyId);
    final userLikeRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("likes")
        .doc(storyId);

    await _firestore.runTransaction((transaction) async {
      final userLikeSnap = await transaction.get(userLikeRef);
      if (!userLikeSnap.exists) {
        transaction.set(userLikeRef, {
          "storyId": storyId,
          "likedAt": FieldValue.serverTimestamp(),
        });
        transaction.update(storyRef, {"likes": FieldValue.increment(1)});
      }
    });
  }

  @override
  Future<void> removeLike(String storyId, String userId) async {
    final storyRef = _firestore.collection("stories").doc(storyId);
    final userLikeRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("likes")
        .doc(storyId);

    await _firestore.runTransaction((transaction) async {
      final userLikeSnap = await transaction.get(userLikeRef);
      if (userLikeSnap.exists) {
        transaction.delete(userLikeRef);
        transaction.update(storyRef, {"likes": FieldValue.increment(-1)});
      }
    });
  }

  @override
  Future<bool> isLiked(String storyId, String userId) async {
    final userLikeRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("likes")
        .doc(storyId);
    final userLikeSnap = await userLikeRef.get();
    return userLikeSnap.exists;
  }

  @override
  Future<void> editStory(StoryData storyData) async {
    try {
      final docRef = _firestore.collection("stories").doc(storyData.storyId);
      await docRef.update(storyData.toMap());
    } catch (e, st) {
      developer.log(
        'Error editing story',
        name: 'StoryRepositoryImpl',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryImpl();
});
