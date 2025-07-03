import 'dart:developer' as developer;

import 'package:athousandwords/commons/widgets/textfields/regular_textfield.dart';
import 'package:athousandwords/core/appmodels/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/widgets/buttons/loading_state_notifier.dart';
import '../../commons/widgets/buttons/regular_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          RegularButton(
            onTap: () async {
              // if (ref.read(experienceRatingProvider) == 0) {
              //   return;
              // }
              final isLoading = ref.read(regularButtonLoadingProvider.notifier);
              isLoading.setLoading("submitStory", true);

              try {
                // final StoryData storyData = StoryData(
                //   reads: reads,
                //   bookmarks: bookmarks,
                //   likes: likes,
                //   readersId: readersId,
                //   bookmarksId: bookmarksId,
                //   likesId: likesId,
                //   userId: userId,
                //   isPublish: isPublish,
                //   isDeleted: isDeleted,
                //   title: title,
                //   createdAt: createdAt,
                //   updatedAt: updatedAt,
                //   content: content,
                //   tags: tags,
                // );
                await ref.read(storyRepositoryProvider).add(reviewData);
              } catch (e) {
                developer.log("Error submitting review: $e");
              } finally {}
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
