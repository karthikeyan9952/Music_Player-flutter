import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/models/position_data.dart';
import 'package:rxdart/rxdart.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final player = AudioPlayer();
  Duration? duration;
  double position = 0;
  bool isPlaying = false;

  Stream<PositionData> get positionDataStream => Rx.combineLatest3(
      player.positionStream,
      player.bufferedPositionStream,
      player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      load();
    });
    super.initState();
  }

  load() async {
    // duration = await player.setFilePath(songs[0].path);
    // logger.e(metadata.trackName);
    // player.play();
    // setState(() {});
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
            const SizedBox(height: SizeUnit.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeUnit.lg),
              child: StreamBuilder(
                  stream: positionDataStream,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    return ProgressBar(
                      barHeight: 4,
                      baseBarColor: Colors.grey[600],
                      bufferedBarColor: Colors.grey,
                      progressBarColor: Colors.white,
                      thumbColor: Colors.white,
                      timeLabelTextStyle: const TextStyle(color: Colors.white),
                      progress: positionData?.position ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      onSeek: player.seek,
                    );
                  }),
            ),
            const SizedBox(height: SizeUnit.sm),
            Controls(player: player),
            // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //   const Spacer(),
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.shuffle, color: Colors.white)),
            //   const Spacer(),
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.skip_previous,
            //         color: Colors.white,
            //         size: 32,
            //       )),
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(
            //         Icons.skip_next,
            //         color: Colors.white,
            //         size: 32,
            //       )),
            //   const Spacer(),
            //   IconButton(
            //       onPressed: () {},
            //       icon: const Icon(Icons.repeat, color: Colors.white)),
            //   const Spacer(),
            // ]),
            const Spacer(),
          ],
        ),
      )
    ]);
  }

  void onPause() {
    setState(() {
      player.playing ? player.pause() : player.play();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

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
