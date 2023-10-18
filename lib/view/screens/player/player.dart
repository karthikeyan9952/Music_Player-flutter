import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/player_provider.dart';
import 'package:musicplayer/repositories/player_repository.dart';
import 'package:musicplayer/utils/extensions/context_extention.dart';
import 'package:musicplayer/view/screens/player/widgets/player_appbar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'widgets/controls.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<PaletteGenerator?>(
            future:
                PlayerRepository().getPaletteGenerator(provider.artworkBytes),
            builder: (BuildContext context,
                AsyncSnapshot<PaletteGenerator?> snapshot) {
              Color bgColor = const Color(0xff530C0C);
              if (snapshot.hasData) {
                bgColor = snapshot.data?.darkMutedColor?.color ??
                    const Color(0xff530C0C);
              }
              return Scaffold(
                backgroundColor: bgColor,
                appBar: PlayerAppbar(
                    context: context, title: "Songs", bgColor: bgColor),
                body: SafeArea(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [bgColor, Colors.black.withOpacity(.65)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.65, 1])),
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
                                      ? const Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colors.white)
                                      : Image.memory(
                                          provider.artworkBytes!,
                                          height: context.widthFull() - 100,
                                          width: context.widthFull() - 100,
                                          fit: BoxFit.cover,
                                        )),
                          const SizedBox(height: SizeUnit.lg * 3),
                          TextCustom("${provider.song?.title}",
                              color: Colors.white, size: 18),
                          TextCustom("${provider.song?.artist}",
                              color: Colors.white70),
                          const SizedBox(height: SizeUnit.lg),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeUnit.lg),
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
                                    progress:
                                        positionData?.position ?? Duration.zero,
                                    total:
                                        positionData?.duration ?? Duration.zero,
                                    buffered: positionData?.bufferedPosition ??
                                        Duration.zero,
                                    onSeek: provider.player.seek,
                                  );
                                }),
                          ),
                          const SizedBox(height: SizeUnit.lg),
                          Controls(player: provider.player),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
