import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/providers.dart';

class Controls extends StatelessWidget {
  const Controls({super.key, required this.player});
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.shuffle, color: Colors.white)),
        const Spacer(),
        IconButton(
            onPressed: playerProvider.handlePrevious,
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 32,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeUnit.sm),
          child: StreamBuilder(
              stream: player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (!(playing ?? false)) {
                  return PlayButton(isPlaying: false, onTap: player.play);
                } else if (processingState != ProcessingState.completed) {
                  return PlayButton(isPlaying: true, onTap: player.pause);
                }
                return PlayButton(isPlaying: true, onTap: player.pause);
              }),
        ),
        IconButton(
            onPressed: playerProvider.handleNext,
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 32,
            )),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.repeat, color: Colors.white)),
      ],
    );
  }
}

class PlayButton extends GestureDetector {
  PlayButton(
      {super.key, required bool isPlaying, required void Function()? onTap})
      : super(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 24,
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
                size: 28,
              ),
            ));
}
