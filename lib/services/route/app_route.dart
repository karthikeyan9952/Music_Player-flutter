import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/view/screens/home.dart';
import 'package:musicplayer/view/screens/library.dart';
import 'package:musicplayer/view/screens/main_screen.dart';
import 'package:musicplayer/view/screens/settings.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    initialLocation: Routes.home,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) => NoTransitionPage(
              child: MainScreen(location: state.uri.toString(), child: child)),
          routes: [
            GoRoute(
              path: Routes.home,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Home()),
            ),
            GoRoute(
              path: Routes.library,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Library()),
            ),
            GoRoute(
              path: Routes.settings,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: Settings()),
            ),
          ])
    ]);
