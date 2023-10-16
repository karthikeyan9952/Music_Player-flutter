import 'package:flutter/material.dart';

class AppBarMain extends AppBar {
  AppBarMain({super.key, required int currentIndex})
      : super(
          title: Text(switch (currentIndex) {
            1 => "Albums",
            2 => "Artists",
            3 => "Playlists",
            _ => "Songs"
          }),
        );
}
