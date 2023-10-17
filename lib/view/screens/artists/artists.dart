import 'package:flutter/cupertino.dart';
import 'package:musicplayer/common/widgets/size_unit.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/view/screens/artists/widgets/artist_item.dart';
import 'package:provider/provider.dart';

class Artists extends StatelessWidget {
  const Artists({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(builder: (context, music, child) {
      return ListView.separated(
          padding: const EdgeInsets.all(SizeUnit.lg),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              ArtistItem(artist: music.artists[index]),
          separatorBuilder: (context, index) =>
              const SizedBox(height: SizeUnit.lg),
          itemCount: music.albums.length);
    });
  }
}
