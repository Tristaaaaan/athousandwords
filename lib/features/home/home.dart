import 'package:athousandwords/commons/textfields/regular_textfield.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController storyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          StoryTextField(
            onChanged: (value) => print(value),
            maxChars: 50,
            fontSize: 40,
            hintText: 'title',
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: StoryTextField(
              hintText: 'tell your story',
              fontSize: 18,
              onChanged: (value) => print(value),
              maxChars: 1500,
            ),
          ),
        ],
      ),
    );
  }
}
