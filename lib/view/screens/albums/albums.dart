import 'package:flutter/cupertino.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/view/screens/albums/widgets/album_grid_item.dart';
import 'package:provider/provider.dart';

class Albums extends StatelessWidget {
  const Albums({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, music, child) {
      return GridView.builder(
          padding: const EdgeInsets.all(SizeUnit.lg),
          shrinkWrap: true,
          itemCount: music.albums.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: SizeUnit.lg,
              crossAxisSpacing: SizeUnit.lg),
          itemBuilder: (context, index) =>
              AlbumGridItem(album: music.albums[index]));
    });
  }
}
