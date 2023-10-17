import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicProvider extends ChangeNotifier {
  List<SongModel> _songs = [];
  List<SongModel> get songs => _songs;
  set songs(List<SongModel> newSongs) {
    _songs = newSongs;
    notifyListeners();
  }

  List<AlbumModel> _albums = [];
  List<AlbumModel> get albums => _albums;
  set albums(List<AlbumModel> newAlbums) {
    _albums = newAlbums;
    notifyListeners();
  }

  List<ArtistModel> _artists = [];
  List<ArtistModel> get artists => _artists;
  set artists(List<ArtistModel> newArtists) {
    _artists = newArtists;
    notifyListeners();
  }
}
