import 'package:athousandwords/features/profile/data/profile_repo_impl.dart';
import 'package:athousandwords/features/profile/domain/profile_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_state.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, ProfileState>(
      (ref) => ProfileController(ref.watch(profileRepositoryProvider)),
    );

class ProfileController extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;
  final FirebaseAuth auth = FirebaseAuth.instance;
  ProfileController(this._repository) : super(const ProfileState.initial()) {
    loadProfileData(); // automatically load
  }

  Future<void> loadProfileData() async {
    state = const ProfileState.loading();

    try {
      final profileData = await _repository.getProfileData(
        auth.currentUser!.uid,
      );

      if (profileData == null) {
        state = const ProfileState.empty();
        return;
      }

      state = ProfileState.loaded(profileData: profileData);
    } catch (e) {
      state = ProfileState.error(e.toString());
    }
  }

  Future<void> refreshDashboard() async {
    await loadProfileData();
  }
}
