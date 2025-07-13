import 'package:athousandwords/core/appmodels/report.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../commons/widgets/buttons/regular_button.dart';
import '../../../report/presentation/widgets/report_dialog.dart';
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
                          bottom: 5,
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
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.report_outlined, size: 18),
                                tooltip: "Report",
                                onPressed: () {
                                  final ReportData reportData = ReportData(
                                    storyId: story!.story.storyId!,
                                    userId: auth.currentUser!.uid,
                                    reportedAt: Timestamp.fromDate(
                                      DateTime.now(),
                                    ),
                                  );
                                  showReportDialog(
                                    context: context,
                                    reportData: reportData,
                                    ref: ref,
                                  );
                                },
                              ),
                              const SizedBox(width: 5),

                              // Likes
                              Row(
                                children: [
                                  Text(
                                    "${story!.story.likes}",
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: Icon(
                                      size: 18,
                                      story.isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_outline_outlined,
                                      color: story.isLiked
                                          ? Colors.red
                                          : Colors.grey[700],
                                    ),
                                    tooltip: story.isLiked ? "Unlike" : "Like",
                                    onPressed: () {
                                      ref
                                          .read(
                                            storyContentControllerProvider
                                                .notifier,
                                          )
                                          .toggleLike(
                                            story.story.storyId!,
                                            auth.currentUser!.uid,
                                          );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(width: 5),

                              // Bookmarks
                              Row(
                                children: [
                                  Text(
                                    "${story.story.bookmarks}",
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 4),
                                  IconButton(
                                    icon: Icon(
                                      size: 18,
                                      story.isBookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline_outlined,
                                      color: story.isBookmarked
                                          ? Colors.blueAccent
                                          : Colors.grey[700],
                                    ),
                                    tooltip: story.isBookmarked
                                        ? "Remove Bookmark"
                                        : "Add Bookmark",
                                    onPressed: () {
                                      ref
                                          .read(
                                            storyContentControllerProvider
                                                .notifier,
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
                          const SizedBox(width: 10),
                          const Expanded(child: Divider(thickness: 1)),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 90,
                            child: RegularButton(
                              onTap: () async {
                                await ref
                                    .read(
                                      storyContentControllerProvider.notifier,
                                    )
                                    .loadNextStory(story.story.storyId!);
                              },
                              width: 80,
                              withIcon: false,
                              text: "Next",
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              textColor: Theme.of(context).colorScheme.surface,
                              buttonKey: "nextButton",
                            ),
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
