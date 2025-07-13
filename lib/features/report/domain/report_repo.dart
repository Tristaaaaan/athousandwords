import 'package:athousandwords/core/appmodels/report.dart';

abstract class ReportRepository {
  Future<void> reportStory(ReportData reportData);
}
