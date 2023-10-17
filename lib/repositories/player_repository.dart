import 'package:flutter/services.dart';
import 'package:musicplayer/providers/providers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerRepository {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  void getArtWork({required int songID}) async {
    // DEFAULT: ArtworkFormat.JPEG, 200 and false
    Uint8List? bytes = await _audioQuery.queryArtwork(
      songID,
      ArtworkType.AUDIO,
    );
    playerProvider.artworkBytes = bytes;
  }
}
