import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_config.dart';
import 'config/app_environments.dart';
import 'core/approutes/app_routes.dart';
import 'core/appthemes/app_themes.dart';
import 'firebase/prod/firebase_options.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.production);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "a-thousand-words",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getBool('theme') ?? true;

  runApp(
    ProviderScope(
      overrides: [
        themeNotifierProvider.overrideWith((ref) => ThemeNotifier(savedTheme)),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    final theme = isDarkMode ? ThemeNotifier.darkMode : ThemeNotifier.lightMode;

    return MaterialApp.router(
      theme: theme,

      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
