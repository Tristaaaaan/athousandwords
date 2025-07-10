import 'package:athousandwords/features/authentication/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/profile_settings_container.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthServices authServices = AuthServices();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: [Container()]),
            ),
          ),

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
