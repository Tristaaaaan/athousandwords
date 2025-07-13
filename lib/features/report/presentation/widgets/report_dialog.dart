import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/appmodels/report.dart';
import '../../data/report_repo_impl.dart';

void showReportDialog({
  required BuildContext context,
  required ReportData reportData,
  required WidgetRef ref,
}) {
  // Save the outer context (from the screen)
  final outerContext = context;

  showDialog(
    context: outerContext,
    builder: (dialogContext) => AlertDialog(
      title: Text('Report'),
      content: Text('Are you sure you want to report this post?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(dialogContext); // Close the dialog first
            try {
              await ref.read(reportRepositoryProvider).reportStory(reportData);
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Story reported successfully.')),
              );
            } catch (e) {
              ScaffoldMessenger.of(outerContext).showSnackBar(
                SnackBar(content: Text('Failed to report story.')),
              );
            }
          },
          child: Text('Report'),
        ),
      ],
    ),
  );
}
