// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookmarkDataImpl _$$BookmarkDataImplFromJson(Map<String, dynamic> json) =>
    _$BookmarkDataImpl(
      storyId: json['storyId'] as String,
      bookmarkedAt:
          const TimestampConverter().fromJson(json['bookmarkedAt'] as Object),
    );

Map<String, dynamic> _$$BookmarkDataImplToJson(_$BookmarkDataImpl instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'bookmarkedAt': const TimestampConverter().toJson(instance.bookmarkedAt),
    };
