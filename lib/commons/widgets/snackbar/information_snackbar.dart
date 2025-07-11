// Information SnackBar, used to show information using a snackbar
import 'package:flutter/material.dart';

void informationSnackBar(BuildContext context, IconData icon, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: IntrinsicHeight(
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.surface),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 4,
      padding: const EdgeInsets.all(20),
    ),
  );
}
