import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/story_controller.dart';

class StoryScreen extends ConsumerStatefulWidget {
  const StoryScreen({super.key});

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    final story = ref.watch(storyContentControllerProvider);

    Future<void> refreshStory() async {
      await ref.read(storyContentControllerProvider.notifier).refreshStory();
    }

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: refreshStory,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              story.when(
                initial: () => SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                ),
                loading: () => SliverFillRemaining(
                  child: const Center(child: CircularProgressIndicator()),
                ),
                loaded: (story) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      StoryTitle(title: story?.title ?? "There is no title"),
                      Divider(
                        color: Colors.grey,
                        thickness: .2,
                        indent: 16,
                        endIndent: 16,
                      ),
                      StoryContent(
                        content: story?.content ?? "There is no content",
                      ),
                    ]),
                  );
                },
                error: (message) =>
                    SliverFillRemaining(child: Center(child: Text(message))),
                empty: () => SliverFillRemaining(
                  child: const Center(child: Text("No story available")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
