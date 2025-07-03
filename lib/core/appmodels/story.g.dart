// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryDataImpl _$$StoryDataImplFromJson(Map<String, dynamic> json) =>
    _$StoryDataImpl(
      reads: (json['reads'] as num).toInt(),
      bookmarks: (json['bookmarks'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      readersId:
          (json['readersId'] as List<dynamic>).map((e) => e as String).toList(),
      bookmarksId: (json['bookmarksId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likesId:
          (json['likesId'] as List<dynamic>).map((e) => e as String).toList(),
      userId: json['userId'] as String,
      isPublish: json['isPublish'] as bool,
      isDeleted: json['isDeleted'] as bool,
      title: json['title'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Object),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Object),
      content: json['content'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$StoryDataImplToJson(_$StoryDataImpl instance) =>
    <String, dynamic>{
      'reads': instance.reads,
      'bookmarks': instance.bookmarks,
      'likes': instance.likes,
      'readersId': instance.readersId,
      'bookmarksId': instance.bookmarksId,
      'likesId': instance.likesId,
      'userId': instance.userId,
      'isPublish': instance.isPublish,
      'isDeleted': instance.isDeleted,
      'title': instance.title,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'content': instance.content,
      'tags': instance.tags,
    };
