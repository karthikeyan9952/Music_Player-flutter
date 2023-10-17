import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/providers.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  const SongTile({super.key, required this.song});
  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(context),
      contentPadding: const EdgeInsets.all(0),
      leading: QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
          artworkBorder: BorderRadius.circular(4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(song.title, maxLines: 1),
          TextCustom(song.artist ?? ""),
        ],
      ),
      trailing: InkWell(onTap: onMore, child: const Icon(Icons.more_vert)),
    );
  }

  void onMore() {}
  void onTap(BuildContext context) {
    playerProvider.song = song;
    context.push(Routes.player);
  }
}
