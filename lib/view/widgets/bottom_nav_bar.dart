import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/services/route/routes.dart';
import 'package:musicplayer/services/theme/pallete.dart';

List<MyCustomBottomNavBarItem> navItems = [
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.music_note_2),
    activeIcon: Icon(CupertinoIcons.music_note_2),
    label: 'Songs',
    initialLocation: Routes.home,
  ),
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.music_albums),
    activeIcon: Icon(CupertinoIcons.music_albums_fill),
    label: 'Albums',
    initialLocation: Routes.albums,
  ),
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.person_2_square_stack),
    activeIcon: Icon(CupertinoIcons.person_2_square_stack_fill),
    label: 'Artists',
    initialLocation: Routes.artists,
  ),
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.music_note_list),
    activeIcon: Icon(CupertinoIcons.music_note_list),
    label: 'Playlists',
    initialLocation: Routes.playlists,
  ),
];

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, this.onTap, required this.selectedIndex});
  final void Function(int)? onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: navItems,
        currentIndex: selectedIndex,
        selectedItemColor: Pallete.primary,
        onTap: onTap,
        selectedLabelStyle: const TextStyle(fontSize: 13, height: 1.5),
        unselectedLabelStyle: const TextStyle(fontSize: 13, height: 1.5),
      ),
    );
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
