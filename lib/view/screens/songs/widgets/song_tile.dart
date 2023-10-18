import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/providers.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  const SongTile(
      {super.key,
      required this.song,
      required this.index,
      required this.songs});
  final SongModel song;
  final int index;
  final List<SongModel> songs;

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
          TextCustom(song.artist ?? "", maxLines: 1),
        ],
      ),
      trailing: PopupMenuButton<String>(
        onSelected: onMore,
        itemBuilder: (BuildContext context) {
          return {'Add to Playlist', 'Add to Favourites'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ),
    );
  }

  void onMore(String value) {}
  void onTap(BuildContext context) {
    playerProvider.play(songs: songs, index: index);
    context.push(Routes.player);
  }
}
