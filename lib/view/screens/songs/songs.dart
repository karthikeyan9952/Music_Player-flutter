import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/view/screens/songs/widgets/song_tile.dart';
import 'package:provider/provider.dart';

class Songs extends StatelessWidget {
  const Songs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, music, child) {
      return ListView.separated(
        padding: const EdgeInsets.all(SizeUnit.lg),
        itemBuilder: (context, index) => SongTile(
          song: music.songs[index],
          index: index,
          songs: music.songs,
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(height: SizeUnit.md / 2),
        shrinkWrap: true,
        itemCount: music.songs.length,
      );
    });
  }
}
