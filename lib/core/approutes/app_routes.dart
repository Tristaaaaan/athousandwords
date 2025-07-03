import 'package:athousandwords/features/authentication/auth_gate.dart';
import 'package:athousandwords/features/home/home.dart';
import 'package:athousandwords/features/story/presentation/screen/story_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',

      builder: (BuildContext context, GoRouterState state) {
        return AuthGate();
      },
    ),
    GoRoute(
      path: '/story',
      builder: (BuildContext context, GoRouterState state) {
        return StoryScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
  ],
);
