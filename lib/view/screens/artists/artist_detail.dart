import 'package:flutter/material.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/common/widgets/text.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/utils/extensions/context_extention.dart';
import 'package:musicplayer/view/screens/albums/widgets/album_item.dart';
import 'package:musicplayer/view/screens/songs/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ArtistDetail extends StatelessWidget {
  const ArtistDetail({super.key, required this.artist});
  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.artist),
      ),
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(SizeUnit.lg),
        children: [
          Center(
            child: QueryArtworkWidget(
              id: artist.id,
              type: ArtworkType.ARTIST,
              artworkBorder: BorderRadius.circular(SizeUnit.lg),
              artworkHeight: context.widthHalf(),
              artworkWidth: context.widthHalf(),
              quality: 100,
              artworkQuality: FilterQuality.high,
            ),
          ),
          const SizedBox(height: SizeUnit.lg * 2),
          const TextCustom("Songs", size: 16),
          const SizedBox(height: SizeUnit.md / 2),
          Consumer<MusicProvider>(
            builder: (context, music, child) {
              List<SongModel> songs = music.songs
                  .where((song) => song.artistId == artist.id)
                  .toList();
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      SongTile(song: songs[index], index: index, songs: songs),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: SizeUnit.md / 2,
                      ),
                  itemCount: songs.length);
            },
          ),
          const SizedBox(height: SizeUnit.lg),
          Consumer<MusicProvider>(
            builder: (context, music, child) {
              List<AlbumModel> albums = music.albums
                  .where((album) => album.artistId == artist.id)
                  .toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                      visible: albums.isNotEmpty,
                      child: const TextCustom("Albums", size: 16)),
                  const SizedBox(height: SizeUnit.sm),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          AlbumItem(album: albums[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: SizeUnit.md,
                          ),
                      itemCount: albums.length),
                ],
              );
            },
          ),
        ],
      )),
    );
  }
}
