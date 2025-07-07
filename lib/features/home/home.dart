import 'dart:developer' as developer;

import 'package:athousandwords/commons/widgets/textfields/regular_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../commons/widgets/buttons/regular_button.dart';
import '../../core/appmodels/story.dart';
import '../story/data/story_impl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Column(
        children: [
          StoryTextField(
            onChanged: (value) => print(value),
            controller: titleController,
            maxChars: 50,
            fontSize: 40,
            hintText: 'title',
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: StoryTextField(
              controller: contentController,
              hintText: 'tell your story',
              fontSize: 18,
              onChanged: (value) => print(value),
              maxChars: 1500,
            ),
          ),
          RegularButton(
            onTap: () async {
              final isLoading = ref.read(regularButtonLoadingProvider.notifier);
              isLoading.setLoading("submitStory", true);

              try {
                final StoryData storyData = StoryData(
                  userId: auth.currentUser!.uid,
                  title: titleController.text,
                  content: contentController.text,
                  createdAt: Timestamp.now(),
                  updatedAt: Timestamp.now(),
                );
                await ref.read(storyRepositoryProvider).createStory(storyData);
              } catch (e) {
                developer.log("Error submitting review: $e");
              } finally {
                titleController.clear();
                contentController.clear();
                isLoading.setLoading("submitStory", false);
              }
            },
            width: double.infinity,
            withIcon: false,
            text: "Submit Review",
            backgroundColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.surface,
            buttonKey: "submitReview",
          ),
        ],
      ),
    );
  }
}
