import 'package:musicplayer/constants/global_objects.dart';
import 'package:musicplayer/providers/music_provider.dart';
import 'package:musicplayer/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
  ChangeNotifierProvider<MusicProvider>(create: (_) => MusicProvider()),
];

var musicProvider =
    Provider.of<MusicProvider>(appKey.currentContext!, listen: false);
