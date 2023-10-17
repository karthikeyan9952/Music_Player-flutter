import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/constants/global_objects.dart';

class AppBarMain extends AppBar {
  AppBarMain({super.key, required int currentIndex})
      : super(title: const Text("Music Player"), actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () => homeKey.currentState!.openEndDrawer(),
              icon: const Icon(Icons.menu))
        ]);
}
