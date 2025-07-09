import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool showAppBars = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        final currentOffset = _scrollController.offset;

        if (currentOffset > _lastOffset + 10 && showAppBars) {
          setState(() => showAppBars = false); // hide top bars
          widget.onScrollDirectionChanged(true); // optional: notify parent
        } else if (currentOffset < _lastOffset - 10 && !showAppBars) {
          setState(() => showAppBars = true); // show top bars
          widget.onScrollDirectionChanged(false); // optional: notify parent
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
                  if (showAppBars)
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 100,
                      surfaceTintColor: Colors.white,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: const EdgeInsetsDirectional.only(
                          start: 16,
                          bottom: 16,
                        ),
                        centerTitle: false,
                        title: Text(
                          story?.story.title ?? "There is no title",
                          style: const TextStyle(
                            fontFamily: 'Merriweather',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  if (showAppBars)
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 0,
                      title: Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1)),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.report_outlined),
                                onPressed: refreshStory,
                              ),
                              Text("${story!.story.likes}"),
                              IconButton(
                                icon: story.isLiked
                                    ? const Icon(Icons.favorite)
                                    : const Icon(
                                        Icons.favorite_outline_outlined,
                                      ),
                                onPressed: () {
                                  ref
                                      .read(
                                        storyContentControllerProvider.notifier,
                                      )
                                      .toggleLike(
                                        story.story.storyId!,
                                        auth.currentUser!.uid,
                                      );
                                },
                              ),

                              Text("${story.story.bookmarks}"),
                              IconButton(
                                icon: Icon(
                                  story.isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline_outlined,
                                ),
                                onPressed: () {
                                  ref
                                      .read(
                                        storyContentControllerProvider.notifier,
                                      )
                                      .toggleBookmark(
                                        story.story.storyId!,
                                        auth.currentUser!.uid,
                                      );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: StoryContent(
                      content: story?.story.content ?? "There is no content",
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
