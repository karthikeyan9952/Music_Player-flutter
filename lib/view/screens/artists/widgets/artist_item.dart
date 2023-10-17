import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/services/theme/pallete.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistItem extends StatelessWidget {
  const ArtistItem({super.key, required this.artist});
  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.artistDetail, extra: artist),
      child: Row(
        children: [
          QueryArtworkWidget(
            id: artist.id,
            type: ArtworkType.ARTIST,
            artworkBorder: BorderRadius.circular(SizeUnit.sm),
            artworkHeight: 64,
            artworkWidth: 64,
          ),
          const SizedBox(width: SizeUnit.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  artist.artist,
                  size: 16,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    TextCustom(
                        "${artist.numberOfTracks} ${artist.numberOfTracks! > 1 ? 'Songs' : 'Song'}"),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeUnit.sm),
                      child: CircleAvatar(
                          radius: 2, backgroundColor: Pallete.secondary),
                    ),
                    TextCustom(
                        "${artist.numberOfAlbums} ${artist.numberOfAlbums! > 1 ? 'Albums' : 'Album'}"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
