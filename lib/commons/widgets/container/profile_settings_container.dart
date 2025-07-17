import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/appthemes/app_themes.dart';

class ProfileSettingsContainer extends ConsumerWidget {
  final bool? withSwitch;
  final String title;
  final IconData icon;
  final bool? notification;
  final void Function(bool)? onChanged;
  final void Function()? onTap;
  final WidgetRef? ref;
  final String? containerKey;
  final bool? withCaption;

  const ProfileSettingsContainer({
    super.key,
    this.withSwitch = false,
    required this.title,
    required this.icon,
    this.onTap,
    this.notification,
    this.ref,
    this.withCaption = false,
    this.onChanged,
    this.containerKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeNotifierProvider.notifier);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),

            // Right side (with bottom border)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title and optional caption
                    Flexible(
                      child: withCaption!
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title, style: TextStyle(fontSize: 10)),
                                const SizedBox(height: 3),
                                Text(
                                  containerKey == "notificationKey"
                                      ? "Enabling this will notify you when a sample containing infested berries is detected."
                                      : "Enabling this will allow you to detect using image sample from your device.",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            )
                          : Text(title, style: TextStyle(fontSize: 14)),
                    ),

                    // Right-side switch or arrow
                    if (withSwitch!)
                      Switch(
                        key: Key(containerKey!),
                        inactiveThumbColor: Theme.of(
                          context,
                        ).colorScheme.primary,
                        activeColor: Theme.of(context).colorScheme.primary,
                        trackOutlineColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.orange.withValues(alpha: .48);
                              }
                              return Theme.of(context).colorScheme.primary;
                            }),
                        value: ref.watch(themeNotifierProvider),
                        onChanged: (values) async {
                          developer.log(
                            "Appearance value: $values",
                            name: "ProfileSettingsContainer",
                          );
                          themeNotifier.toggleTheme();
                          final isLightMode = ref.read(themeNotifierProvider);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool("theme", isLightMode);
                        },
                      )
                    else
                      Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
