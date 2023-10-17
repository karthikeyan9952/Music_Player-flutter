import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/player_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/controls.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xff530C0C),
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(SizeUnit.lg),
              child: Column(
                children: [
                  const Spacer(),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: provider.isLoadingArtwork
                          ? const CircularProgressIndicator()
                          : provider.artworkBytes == null
                              ? const Icon(Icons.image_not_supported_outlined,
                                  color: Colors.white)
                              : Image.memory(
                                  provider.artworkBytes!,
                                  height: 126,
                                  width: 126,
                                )),
                  const SizedBox(height: SizeUnit.lg + SizeUnit.sm),
                  TextCustom("${provider.song?.title}",
                      color: Colors.white, size: 18),
                  TextCustom("${provider.song?.artist}", color: Colors.white70),
                  const SizedBox(height: SizeUnit.lg),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: SizeUnit.lg),
                    child: StreamBuilder(
                        stream: provider.positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return ProgressBar(
                            barHeight: 4,
                            baseBarColor: Colors.grey[600],
                            bufferedBarColor: Colors.grey,
                            progressBarColor: Colors.white,
                            thumbColor: Colors.white,
                            timeLabelTextStyle:
                                const TextStyle(color: Colors.white),
                            progress: positionData?.position ?? Duration.zero,
                            total: positionData?.duration ?? Duration.zero,
                            buffered:
                                positionData?.bufferedPosition ?? Duration.zero,
                            onSeek: provider.player.seek,
                          );
                        }),
                  ),
                  const SizedBox(height: SizeUnit.sm),
                  Controls(player: provider.player),
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
            ),
          ),
        );
      },
    );
  }
}
