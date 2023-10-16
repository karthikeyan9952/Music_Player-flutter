import 'package:musicplayer/providers/providers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<void> init() async {
    await getSongs();
    await getAlbums();
    await getArtists();
  }

  Future<void> getSongs() async {
    List<SongModel> songs = await _audioQuery.querySongs();
    musicProvider.songs = songs;
  }

  Future<void> getAlbums() async {
    List<AlbumModel> albums = await _audioQuery.queryAlbums();
    musicProvider.albums = albums;
  }

  Future<void> getArtists() async {
    List<ArtistModel> artists = await _audioQuery.queryArtists();
    musicProvider.artists = artists;
  }

  checkAndRequestPermissions({bool retry = false}) async {
    return await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
  }
}
