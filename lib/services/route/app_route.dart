import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/repositories/music_repository.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/view/screens/albums/album_detail.dart';
import 'package:musicplayer/view/screens/albums/albums.dart';
import 'package:musicplayer/view/screens/artists/artist_detail.dart';
import 'package:musicplayer/view/screens/artists/artists.dart';
import 'package:musicplayer/view/screens/player/player.dart';
import 'package:musicplayer/view/screens/songs/songs.dart';
import 'package:musicplayer/view/screens/playlists/playlists.dart';
import 'package:musicplayer/view/screens/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
        ]),
    GoRoute(
      path: Routes.albumDetail,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        AlbumModel album = state.extra as AlbumModel;
        return AlbumDetail(album: album);
      },
    ),
    GoRoute(
      path: Routes.artistDetail,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        ArtistModel artist = state.extra as ArtistModel;
        return ArtistDetail(artist: artist);
      },
    ),
    GoRoute(
      path: Routes.player,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (BuildContext context, GoRouterState state) {
        return const Player();
      },
    ),
  ],
  redirect: (context, state) async {
    bool hasPermission = await MusicRepository().checkAndRequestPermissions();
    if (!hasPermission) {}

    return null;
  },
);
