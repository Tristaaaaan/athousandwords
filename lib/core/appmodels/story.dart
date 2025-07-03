import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class StoryData with _$StoryData {
  const StoryData._();

  const factory StoryData({
    required int reads,
    required int bookmarks,
    required int likes,
    required List<String> readersId,
    required List<String> bookmarksId,
    required List<String> likesId,
    required String userId,
    required bool isPublish,
    required bool isDeleted,
    required String title,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
    required String content,
    required List<String> tags,
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
