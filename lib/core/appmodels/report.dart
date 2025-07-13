import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bookmark.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
class ReportData with _$ReportData {
  const ReportData._(); // Allows custom methods below

  const factory ReportData({
    String? reportId,
    required String userId,
    required String storyId,
    @TimestampConverter() required Timestamp reportedAt,
  }) = _ReportData;

  factory ReportData.fromJson(Map<String, dynamic> json) =>
      _$ReportDataFromJson(json);

  Map<String, dynamic> toMap() => toJson();

  // Example custom method
  String formattedDate() => reportedAt.toDate().toLocal().toString();
}
