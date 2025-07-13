// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportDataImpl _$$ReportDataImplFromJson(Map<String, dynamic> json) =>
    _$ReportDataImpl(
      reportId: json['reportId'] as String?,
      userId: json['userId'] as String,
      storyId: json['storyId'] as String,
      reportedAt:
          const TimestampConverter().fromJson(json['reportedAt'] as Object),
    );

Map<String, dynamic> _$$ReportDataImplToJson(_$ReportDataImpl instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'userId': instance.userId,
      'storyId': instance.storyId,
      'reportedAt': const TimestampConverter().toJson(instance.reportedAt),
    };
