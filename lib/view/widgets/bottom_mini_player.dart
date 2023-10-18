import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/player_provider.dart';
import 'package:musicplayer/repositories/player_repository.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class BottomMiniPlayer extends StatelessWidget {
  const BottomMiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        return Visibility(
          visible: provider.song != null,
          child: GestureDetector(
            onTap: () => context.push(Routes.player),
            child: Padding(
              padding: const EdgeInsets.all(SizeUnit.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FutureBuilder<PaletteGenerator?>(
                      future: PlayerRepository()
                          .getPaletteGenerator(provider.artworkBytes),
                      builder: (context, snapshot) {
                        Color bgColor = const Color(0xff530C0C);
                        if (snapshot.hasData) {
                          bgColor = snapshot.data?.darkMutedColor?.color ??
                              const Color(0xff530C0C);
                        }
                        return Container(
                          padding: const EdgeInsets.fromLTRB(
                              SizeUnit.sm, SizeUnit.sm, SizeUnit.sm, 0),
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.memory(
                                      provider.artworkBytes!,
                                      height: 36,
                                      width: 36,
                                    ),
                                  ),
                                  const SizedBox(width: SizeUnit.sm),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          "${provider.song?.title}",
                                          color: Colors.white,
                                        ),
                                        const TextCustom(
                                          "Extenal Speakers",
                                          color: Colors.white70,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: SizeUnit.lg),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: SizeUnit.md),
                                        StreamBuilder(
                                            stream: provider
                                                .player.playerStateStream,
                                            builder: (context, snapshot) {
                                              final playerState = snapshot.data;
                                              final processingState =
                                                  playerState?.processingState;
                                              final playing =
                                                  playerState?.playing;
                                              if (!(playing ?? false)) {
                                                return PauseButtonMini(
                                                    isPlaying: false,
                                                    onTap:
                                                        provider.player.play);
                                              } else if (processingState !=
                                                  ProcessingState.completed) {
                                                return PauseButtonMini(
                                                    isPlaying: true,
                                                    onTap:
                                                        provider.player.pause);
                                              }
                                              return PauseButtonMini(
                                                  isPlaying: true,
                                                  onTap: provider.player.pause);
                                            })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                              const LinearProgressIndicator(
                                minHeight: 2,
                                value: .5,
                                color: Colors.white,
                                backgroundColor: Colors.white12,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PauseButtonMini extends GestureDetector {
  PauseButtonMini(
      {super.key, required bool isPlaying, required void Function()? onTap})
      : super(
            onTap: onTap,
            child: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white));
}
