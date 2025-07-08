import 'package:flutter/material.dart';

class StoryContent extends StatelessWidget {
  final String content;
  const StoryContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 100),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        content,
        style: TextStyle(fontFamily: 'Merriweather', fontSize: 18),
        softWrap: true,
      ),
    );
  }
}
