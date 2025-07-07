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
  Future<StoryData> getStory() async {
    try {
      final snapshot = await _firestore.collection("stories").get();
      return StoryData.fromJson(snapshot.docs.first.data());
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
}

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepositoryImpl();
});
