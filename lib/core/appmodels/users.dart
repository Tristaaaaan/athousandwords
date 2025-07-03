import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

@freezed
class UserData with _$UserData {
  const UserData._(); // Private constructor for custom methods

  const factory UserData({
    required String uid,
    required String fullName,
    required String email,
    String? fcmToken,
    String? imageUrl,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  /// Converts the object to a map (identical to toJson in this case).
  Map<String, dynamic> toMap() => toJson();
}
