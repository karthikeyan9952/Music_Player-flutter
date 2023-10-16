import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/repositories/music_repository.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/view/screens/albums/albums.dart';
import 'package:musicplayer/view/screens/artists/artists.dart';
import 'package:musicplayer/view/screens/songs/songs.dart';
import 'package:musicplayer/view/screens/playlists/playlists.dart';
import 'package:musicplayer/view/screens/home_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) => NoTransitionPage(
            child: HomeScreen(location: state.uri.toString(), child: child)),
        routes: [
          GoRoute(
            path: Routes.home,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Songs()),
          ),
          GoRoute(
            path: Routes.albums,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Albums()),
          ),
          GoRoute(
            path: Routes.artists,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Artists()),
          ),
          GoRoute(
            path: Routes.playlists,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: Playlists()),
          ),
        ])
  ],
  redirect: (context, state) async {
    bool hasPermission = await MusicRepository().checkAndRequestPermissions();
    if (!hasPermission) {}

    return null;
  },
);
