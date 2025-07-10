import 'package:athousandwords/core/appmodels/story.dart';
import 'package:athousandwords/core/appmodels/users.dart';

abstract class ProfileRepository {
  Future<ProfileData?> getProfileData(String userId);
}

class ProfileData {
  final UserData user;
  final StoryData? story;

  ProfileData({required this.user, required this.story});
}
