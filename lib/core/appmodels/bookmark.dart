import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
class BookmarkData with _$BookmarkData {
  const BookmarkData._();

  const factory BookmarkData({
    required String storyId,

    @TimestampConverter() required Timestamp bookmarkedAt,
  }) = _BookmarkData;

  factory BookmarkData.fromJson(Map<String, dynamic> json) =>
      _$BookmarkDataFromJson(json);

  Map<String, dynamic> toMap() => toJson();
}

class TimestampConverter implements JsonConverter<Timestamp, Object> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Object json) {
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic> &&
        json.containsKey('_seconds') &&
        json.containsKey('_nanoseconds')) {
      return Timestamp(json['_seconds'], json['_nanoseconds']);
    }
    throw ArgumentError('Invalid Timestamp format: $json');
  }

  @override
  Object toJson(Timestamp timestamp) => timestamp;
}
