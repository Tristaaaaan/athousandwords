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

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                story.when(
                  initial: () => const CircularProgressIndicator(),
                  loading: () => const CircularProgressIndicator(),
                  loaded: (story) {
                    return Text(story!.title);
                  },
                  error: (message) => Text(message),
                  empty: () => const CircularProgressIndicator(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
