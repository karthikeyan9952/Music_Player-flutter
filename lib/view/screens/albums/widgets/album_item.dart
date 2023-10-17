import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({super.key, required this.album});
  final AlbumModel album;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Routes.albumDetail, extra: album),
      child: Row(
        children: [
          QueryArtworkWidget(
            id: album.id,
            type: ArtworkType.ALBUM,
            artworkBorder: BorderRadius.circular(SizeUnit.sm),
            artworkHeight: 76,
            artworkWidth: 76,
          ),
          const SizedBox(width: SizeUnit.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  album.album,
                  size: 16,
                ),
                const SizedBox(height: 4),
                TextCustom(
                  album.artist ?? "",
                  color: Colors.black54,
                ),
                const SizedBox(height: 2),
                TextCustom(
                    "${album.numOfSongs} ${album.numOfSongs > 1 ? 'Songs' : 'Song'}",
                    size: 13),
              ],
            ),
          )
        ],
      ),
    );
  }
}
