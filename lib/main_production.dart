import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_config.dart';
import 'config/app_environments.dart';
import 'core/approutes/app_routes.dart';
import 'core/appthemes/app_themes.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.production);

  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   name: "a-thousand-words-dev",
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider.notifier).currentTheme;

    return MaterialApp.router(
      theme: theme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
