import 'package:athousandwords/core/appmodels/report.dart';
import 'package:athousandwords/features/report/domain/report_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

class ReportRepoImpl extends ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> reportStory(ReportData reportData) async {
    try {
      final reportsCollection = _firestore.collection('reports');

      final docRef = reportData.reportId != null
          ? reportsCollection.doc(reportData.reportId)
          : reportsCollection.doc();

      final dataWithId = reportData.copyWith(
        reportId: docRef.id,
        reportedAt: Timestamp.now(),
      );

      await docRef.set(dataWithId.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  return ReportRepoImpl();
});
