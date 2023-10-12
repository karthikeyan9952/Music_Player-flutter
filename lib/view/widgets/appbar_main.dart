import 'package:flutter/material.dart';

class AppBarMain extends AppBar {
  AppBarMain({super.key, required int currentIndex})
      : super(
            title: Text(switch (currentIndex) {
              1 => "Library",
              2 => "Settings",
              _ => "Music Player"
            }),
            centerTitle: true);
}
