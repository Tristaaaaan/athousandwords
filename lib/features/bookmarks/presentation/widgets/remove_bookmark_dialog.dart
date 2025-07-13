import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/widgets/snackbar/information_snackbar.dart';
import '../../../story/presentation/provider/story_controller.dart';

void showRemoveBookmarkDialog({
  required BuildContext context,
  required String storyId,
  required String userId,
  required WidgetRef ref,
}) {
  final outerContext = context;

  showDialog(
    context: outerContext,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Remove Bookmark'),
      content: const Text('Are you sure you want to remove this bookmark?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(dialogContext);

            await ref
                .read(storyContentControllerProvider.notifier)
                .toggleBookmark(storyId, userId);

            if (outerContext.mounted) {
              informationSnackBar(outerContext, Icons.info, "Bookmark removed");
            }
          },
          child: const Text('Remove'),
        ),
      ],
    ),
  );
}
