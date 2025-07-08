import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/story_controller.dart';

class StoryScreen extends ConsumerStatefulWidget {
  final void Function(bool isScrollingDown) onScrollDirectionChanged;

  const StoryScreen({super.key, required this.onScrollDirectionChanged});

  @override
  ConsumerState<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  late final ScrollController _scrollController;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final currentOffset = _scrollController.offset;

        if (currentOffset > _lastOffset + 10) {
          widget.onScrollDirectionChanged(true); // scrolling down
        } else if (currentOffset < _lastOffset - 10) {
          widget.onScrollDirectionChanged(false); // scrolling up
        }

        _lastOffset = currentOffset;
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 100,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white, // optional for Material 3
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: const EdgeInsetsDirectional.only(
                        start: 16,
                        bottom: 16,
                      ),
                      centerTitle: false,
                      title: Text(
                        story?.title ?? "There is no title",
                        style: const TextStyle(
                          fontFamily: 'Merriweather',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      collapseMode: CollapseMode.parallax, // optional
                      background:
                          Container(), // empty or add a background image
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    surfaceTintColor: Colors.white, // optional for Material 3
                    elevation: 0,
                    title: Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        const SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.report_outlined),
                              onPressed: refreshStory,
                            ),
                            IconButton(
                              icon: const Icon(Icons.favorite_outline_outlined),
                              onPressed: refreshStory,
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark_outline_outlined),
                              onPressed: refreshStory,
                            ),
                          ],
                        ),
                      ],
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
