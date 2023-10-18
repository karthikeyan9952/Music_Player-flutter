import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/models/position_data.dart';
import 'package:musicplayer/repositories/player_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';

class PlayerProvider extends ChangeNotifier {
  final _player = AudioPlayer();
  AudioPlayer get player => _player;

  Stream<PositionData> get positionDataStream => Rx.combineLatest3(
      player.positionStream,
      player.bufferedPositionStream,
      player.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero));

  SongModel? _song;
  SongModel? get song => _song;
  set song(SongModel? newSong) {
    _song = newSong;
    newSong != null ? PlayerRepository().getArtWork(songID: newSong.id) : null;
    notifyListeners();
  }

  Uint8List? _artworkBytes;
  Uint8List? get artworkBytes => _artworkBytes;
  set artworkBytes(Uint8List? bytes) {
    _artworkBytes = bytes;
    notifyListeners();
  }

  bool _isLoadingArtwork = false;
  bool get isLoadingArtwork => _isLoadingArtwork;
  set isLoadingArtwork(bool value) {
    _isLoadingArtwork = value;
    notifyListeners();
  }

  ConcatenatingAudioSource? _playlist;
  ConcatenatingAudioSource? get playlist => _playlist;
  set playlist(ConcatenatingAudioSource? list) {
    _playlist = list;
    notifyListeners();
  }

  List<SongModel> _currentSongs = [];
  List<SongModel> get currentSongs => _currentSongs;
  set currentSongs(List<SongModel> songs) {
    _currentSongs = songs;
    notifyListeners();
  }

  void play({required List<SongModel> songs, required int index}) async {
    currentSongs = songs;
    song = songs[index];
    List<File> songFiles = songs.map((song) => File(song.data)).toList();
    final currentPlaylist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        shuffleOrder: DefaultShuffleOrder(),
        children: List.generate(songFiles.length,
            (index) => AudioSource.file(songFiles[index].path)));

    await player.setAudioSource(currentPlaylist,
        initialIndex: index, initialPosition: Duration.zero);
    player.play();
    listener();
  }

  void handleNext() async {
    await player.seekToNext();
    if (player.currentIndex == null) return;
    song = currentSongs[player.currentIndex!];
  }

  void handlePrevious() async {
    await player.seekToPrevious();
    if (player.currentIndex == null) return;
    song = currentSongs[player.currentIndex!];
  }

  void listener() {
    player.currentIndexStream.listen((newIndex) {
      song = newIndex != null ? currentSongs[newIndex] : null;
    });
  }
}
