import 'package:flutter/cupertino.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/view/screens/albums/widgets/album_item.dart';
import 'package:provider/provider.dart';

class Albums extends StatelessWidget {
  const Albums({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, music, child) {
      return ListView.separated(
          padding: const EdgeInsets.all(SizeUnit.lg),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              AlbumItem(album: music.albums[index]),
          separatorBuilder: (context, index) =>
              const SizedBox(height: SizeUnit.lg),
          itemCount: music.albums.length);
    });
  }
}
