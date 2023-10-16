import 'package:flutter/material.dart';
import 'package:musicplayer/constants/global_objects.dart';
import 'package:musicplayer/providers/providers.dart';
import 'package:musicplayer/providers/theme_provider.dart';
import 'package:musicplayer/services/route/app_route.dart';
import 'package:musicplayer/services/theme/theme_constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return MaterialApp.router(
          key: appKey,
          debugShowCheckedModeBanner: false,
          title: 'Music Player',
          themeMode: theme.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: router,
        );
      },
    );
  }
}
