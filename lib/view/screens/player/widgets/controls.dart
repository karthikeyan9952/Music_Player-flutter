import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({super.key, required this.player});
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return GestureDetector(
                onTap: player.play,
                child: const CircleAvatar(child: Icon(Icons.play_arrow)));
          } else if (processingState != ProcessingState.completed) {
            return GestureDetector(
                onTap: player.pause,
                child: const CircleAvatar(child: Icon(Icons.pause)));
          }
          return GestureDetector(
              onTap: player.pause,
              child: const CircleAvatar(child: Icon(Icons.pause)));
        });
  }
}
