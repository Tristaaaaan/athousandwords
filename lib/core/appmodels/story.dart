import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class StoryData with _$StoryData {
  const StoryData._();

  const factory StoryData({
    String? storyId, // 🔁 Renamed from id to storyId

    @Default(0) int reads,
    @Default(0) int bookmarks,
    @Default(0) int likes,

    @Default([]) List<String> readersId,
    @Default([]) List<String> bookmarksId,
    @Default([]) List<String> likesId,

    @Default('') String userId,
    @Default(false) bool isPublish,
    @Default(false) bool isDeleted,
    @Default('') String title,

    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,

    @Default('') String content,
    @Default([]) List<String> tags,
  }) = _StoryData;

  factory StoryData.fromJson(Map<String, dynamic> json) =>
      _$StoryDataFromJson(json);

  Map<String, dynamic> toMap() => toJson();
}

// Add this converter to handle Timestamp <-> DateTime conversion
class TimestampConverter implements JsonConverter<Timestamp, Object> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Object json) => Timestamp.fromMillisecondsSinceEpoch(
    (json as Timestamp).millisecondsSinceEpoch,
  );

  @override
  Object toJson(Timestamp timestamp) => timestamp;
}
