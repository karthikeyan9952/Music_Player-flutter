import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/constants/global_objects.dart';
import 'package:musicplayer/utils/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final player = AudioPlayer();
  Duration? duration;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      load();
    });
    super.initState();
  }

  load() async {
    await getStoragePermission();
    Directory dir = Directory('/storage/emulated/0/download/');
    String mp3Path = dir.toString();
    logger.i(mp3Path);
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _songs = [];
    _files = dir.listSync(recursive: true, followLinks: false);
    for (FileSystemEntity entity in _files) {
      String path = entity.path;
      if (path.endsWith('.mp3')) _songs.add(entity);
    }
    logger.i(_songs[0].path);
    logger.i(_songs.length);

    duration = await player.setFilePath(_songs[0].path);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/cover.jpg",
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black54,
      ),
      Center(
        child: Column(
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/cover.jpg",
                height: 126,
                width: 126,
              ),
            ),
            const SizedBox(height: SizeUnit.lg + SizeUnit.sm),
            const TextCustom("Hukum - Thalaivar Alappara",
                color: Colors.white, size: 18),
            const TextCustom("Anirudh Ravichander, Super Subu",
                color: Colors.white70),
            const Spacer(),
          ],
        ),
      )
    ]);
  }
}
