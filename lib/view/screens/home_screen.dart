import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/constants/global_objects.dart';
import 'package:musicplayer/repositories/music_repository.dart';
import 'package:musicplayer/utils/message.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/view/widgets/appbar_main.dart';
import 'package:musicplayer/view/widgets/bottom_mini_player.dart';
import 'package:musicplayer/view/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.location, required this.child});
  final String location;
  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MusicRepository().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndex = switch (widget.location) {
      Routes.albums => 1,
      Routes.artists => 2,
      Routes.playlists => 3,
      _ => 0
    };
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: homeKey,
        appBar: AppBarMain(currentIndex: _selectedIndex),
        body: SafeArea(
            child: Stack(
          children: [widget.child, const BottomMiniPlayer()],
        )),
        bottomNavigationBar: BottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: (index) => onChangeTab(index)),
        endDrawer: const Drawer(),
      ),
    );
  }

  onChangeTab(int index) {
    if (index == _selectedIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = navItems[index].initialLocation;

    setState(() {
      _selectedIndex = index;
    });
    router.go(location);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToastMessage("Press again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
