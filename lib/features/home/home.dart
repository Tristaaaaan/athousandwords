import 'dart:developer' as developer;

import 'package:athousandwords/commons/widgets/textfields/regular_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/widgets/buttons/loading_state_notifier.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 1,
            title: const Text(
              "Write your story",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextButton(
                  onPressed: () async {
                    final isLoading = ref.read(
                      regularButtonLoadingProvider.notifier,
                    );
                    isLoading.setLoading("submitStory", true);

                    try {
                      final StoryData storyData = StoryData(
                        userId: auth.currentUser!.uid,
                        title: titleController.text,
                        content: contentController.text,
                        createdAt: Timestamp.now(),
                        updatedAt: Timestamp.now(),
                      );
                      await ref
                          .read(storyRepositoryProvider)
                          .createStory(storyData);
                    } catch (e) {
                      developer.log("Error submitting review: $e");
                    } finally {
                      titleController.clear();
                      contentController.clear();
                      isLoading.setLoading("submitStory", false);
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Text(
                        "Post",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.send, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              StoryTextField(
                onChanged: (value) => print(value),
                controller: titleController,
                minWords: 1,
                maxWords: 8,
                fontSize: 40,
                hintText: 'title',
              ),
              const SizedBox(height: 16),
              StoryTextField(
                controller: contentController,
                hintText: 'tell your story',
                fontSize: 18,
                onChanged: (value) => print(value),
                minWords: 1000,
                maxWords: 1500,
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ],
      ),
    );
  }
}
