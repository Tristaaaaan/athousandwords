import 'package:flutter/material.dart';

class StoryTitle extends StatelessWidget {
  final String title;
  const StoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 50),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Merriweather',
          fontSize: 42,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
