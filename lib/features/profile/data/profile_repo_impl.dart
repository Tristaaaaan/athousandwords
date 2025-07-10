import 'dart:developer' as developer;

import 'package:athousandwords/core/appmodels/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/appmodels/story.dart';
import '../domain/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;
  @override
  @override
  Future<ProfileData> getProfileData(String userId) async {
    try {
      // Step 1: Fetch user document
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception("User document not found for ID: $userId");
      }

      final userData = UserData.fromJson(userDoc.data()!);
      final storyId = userData.storyId;

      StoryData? storyData;

      // Step 2: Check if storyId is valid (not null or empty)
      if (storyId != null && storyId.trim().isNotEmpty) {
        final storyDoc = await _firestore
            .collection('stories')
            .doc(storyId)
            .get();

        if (storyDoc.exists) {
          storyData = StoryData.fromJson(storyDoc.data()!);
        } else {
          developer.log(
            'Story not found for storyId: $storyId (userId: $userId)',
            name: 'ProfileRepoImpl',
          );
        }
      } else {
        developer.log(
          'No valid storyId for userId: $userId',
          name: 'ProfileRepoImpl',
        );
      }

      // Step 3: Return ProfileData
      return ProfileData(user: userData, story: storyData);
    } catch (e, st) {
      developer.log(
        'Error getting profile data for userId: $userId',
        name: 'ProfileRepoImpl',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepoImpl();
});
