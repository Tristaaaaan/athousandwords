import 'package:athousandwords/features/report/domain/model/report.dart';

abstract class ReportRepository {
  Future<void> reportStory(ReportData reportData);
}
