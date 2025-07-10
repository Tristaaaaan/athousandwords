import 'package:athousandwords/features/authentication/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_settings_container.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthServices authServices = AuthServices();
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   leading: IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     color: Theme.of(
          //       context,
          //     ).colorScheme.surface, //), // 👈 Set custom color
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   expandedHeight: 430,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Stack(
          //       children: [
          //         SizedBox(
          //           width: double.infinity,
          //           height: 400,
          //           child: CachedNetworkImage(
          //             imageUrl: studio.imageUrl,
          //             fit: BoxFit.cover,
          //             width: double.infinity,
          //             height: double.infinity,
          //             errorWidget: (context, url, error) =>
          //                 const Icon(Icons.broken_image),
          //             placeholder: (context, url) => Shimmer.fromColors(
          //               baseColor: Colors.grey[400]!,
          //               highlightColor: Colors.grey[300]!,
          //               child: Container(
          //                 width: double.infinity,
          //                 height: double.infinity,
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(5),
          //                   color: Theme.of(context).colorScheme.tertiary,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         SizedBox(
          //           width: double.infinity,
          //           height: 425,
          //           child: Align(
          //             alignment: Alignment.bottomRight,
          //             child: Container(
          //               width: 60,
          //               height: 60,
          //               margin: const EdgeInsets.only(right: 15),
          //               decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 shape: BoxShape.circle,
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Colors.black26,
          //                     blurRadius: 4,
          //                     offset: Offset(0, 2),
          //                   ),
          //                 ],
          //               ),
          //               child: GestureDetector(
          //                 onTap: () async {
          //                   await studioService.execute(
          //                     isFollowing,
          //                     studio.id,
          //                     userId,
          //                   );
          //                 },
          //                 child: isFollowing
          //                     ? const Icon(Icons.favorite, color: Colors.red)
          //                     : const Icon(
          //                         Icons.favorite_border,
          //                         color: Colors.grey,
          //                       ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              ProfileSettingsContainer(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () async {
                  await authServices.signOutAccount(ref);
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
