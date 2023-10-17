import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatefulWidget {
  const SongTile({super.key, required this.song});
  final SongModel song;

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      leading: QueryArtworkWidget(
          id: widget.song.id,
          type: ArtworkType.AUDIO,
          artworkBorder: BorderRadius.circular(4)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.song.title, maxLines: 1),
          TextCustom(widget.song.artist ?? ""),
        ],
      ),
      trailing: InkWell(onTap: onMore, child: const Icon(Icons.more_vert)),
    );
  }

  onMore() {}
}
