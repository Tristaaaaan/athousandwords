import 'package:athousandwords/features/authentication/auth_services.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_content.dart';
import 'package:athousandwords/features/story/presentation/widgets/story_title.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/profile_controller.dart';

String getHighResPhotoUrl(String? photoUrl) {
  // Replace resolution specifier (e.g., s96-c) with s512-c
  return photoUrl!.replaceFirst(RegExp(r'=s\d+-c$'), '=s512-c');
}

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final AuthServices authServices = AuthServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(profileControllerProvider);

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            ...profileData.when(
              initial: () => [const SliverToBoxAdapter(child: SizedBox())],
              loading: () => [
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (message) => [
                SliverToBoxAdapter(
                  child: Center(child: Text('Error: $message')),
                ),
              ],
              empty: () => [
                const SliverToBoxAdapter(
                  child: Center(child: Text('No profile data available')),
                ),
              ],
              loaded: (profileData) => [
                SliverAppBar(
                  expandedHeight: 400,
                  floating: false,

                  actions: [
                    InkWell(
                      onTap: () async {
                        await authServices.signOutAccount(ref);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12, top: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.surface,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        // Background image
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: CachedNetworkImage(
                            imageUrl: profileData.user.imageUrl != null
                                ? getHighResPhotoUrl(profileData.user.imageUrl!)
                                : '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.broken_image),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Gradient overlay at the bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black54,
                                  Colors.black87,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Name text
                        Positioned(
                          bottom: 40,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              profileData.user.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    StoryTitle(title: profileData.story?.title ?? 'No Title'),
                    Divider(thickness: 1, indent: 16, endIndent: 16),
                    StoryContent(
                      content:
                          profileData.story?.content ??
                          'Currently no story added',
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
