import 'package:riverpod/riverpod.dart';

import '../domain/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepository {
  @override
  Future<ProfileData> getProfileData(String userId) {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepoImpl();
});
