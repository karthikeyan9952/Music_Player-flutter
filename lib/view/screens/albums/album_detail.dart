import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/utils/extensions/context_extention.dart';
import 'package:musicplayer/view/screens/songs/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AlbumDetail extends StatelessWidget {
  const AlbumDetail({super.key, required this.album});
  final AlbumModel album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.album),
      ),
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(SizeUnit.lg),
        children: [
          Center(
            child: QueryArtworkWidget(
              id: album.id,
              type: ArtworkType.ALBUM,
              artworkBorder: BorderRadius.circular(SizeUnit.lg),
              artworkHeight: context.widthHalf(),
              artworkWidth: context.widthHalf(),
              quality: 100,
              artworkQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(height: SizeUnit.lg * 2),
          Consumer<MusicProvider>(
            builder: (context, music, child) {
              List<SongModel> songs = music.songs
                  .where((song) => song.albumId == album.id)
                  .toList();
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SongTile(
                        song: songs[index],
                        index: index,
                        songs: songs,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: SizeUnit.md / 2,
                      ),
                  itemCount: songs.length);
            },
          )
        ],
      )),
    );
  }
}
