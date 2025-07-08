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
          child: story.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (story) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 140,
                    flexibleSpace: FlexibleSpaceBar(
                      background: StoryTitle(
                        title: story?.title ?? "There is no title",
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: refreshStory,
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: refreshStory,
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh),
                            onPressed: refreshStory,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: StoryContent(
                      content: story?.content ?? "There is no content",
                    ),
                  ),
                ],
              );
            },
            error: (message) => Center(child: Text(message)),
            empty: () => const Center(child: Text("No story available")),
          ),
        ),
      ),
    );
  }
}
