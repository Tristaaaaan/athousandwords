// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryDataImpl _$$StoryDataImplFromJson(Map<String, dynamic> json) =>
    _$StoryDataImpl(
      storyId: json['storyId'] as String?,
      reads: (json['reads'] as num?)?.toInt() ?? 0,
      bookmarks: (json['bookmarks'] as num?)?.toInt() ?? 0,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      readersId: (json['readersId'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userId: json['userId'] as String? ?? '',
      isPublish: json['isPublish'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      title: json['title'] as String? ?? '',
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Object),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Object),
      content: json['content'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$StoryDataImplToJson(_$StoryDataImpl instance) =>
    <String, dynamic>{
      'storyId': instance.storyId,
      'reads': instance.reads,
      'bookmarks': instance.bookmarks,
      'likes': instance.likes,
      'readersId': instance.readersId,
      'userId': instance.userId,
      'isPublish': instance.isPublish,
      'isDeleted': instance.isDeleted,
      'title': instance.title,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'content': instance.content,
      'tags': instance.tags,
    };
