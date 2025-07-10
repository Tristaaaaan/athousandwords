import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/profile_repo.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded({required ProfileData profileData}) =
      _Loaded;
  const factory ProfileState.error(String message) = _Error;
  const factory ProfileState.empty() = _Empty;
}
