import 'package:flutter/cupertino.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumGridItem extends StatelessWidget {
  const AlbumGridItem({super.key, required this.album});
  final AlbumModel album;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: album.id,
      type: ArtworkType.ALBUM,
      artworkBorder: BorderRadius.circular(SizeUnit.sm),
    );
  }
}
