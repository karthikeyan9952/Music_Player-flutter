import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/utils/route/routes.dart';
import 'package:musicplayer/utils/theme/pallete.dart';

List<MyCustomBottomNavBarItem> navItems = [
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.house),
    activeIcon: Icon(CupertinoIcons.house_fill),
    label: 'Home',
    initialLocation: Routes.home,
  ),
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.bookmark),
    activeIcon: Icon(CupertinoIcons.bookmark_fill),
    label: 'Library',
    initialLocation: Routes.library,
  ),
  const MyCustomBottomNavBarItem(
    icon: Icon(CupertinoIcons.gear),
    activeIcon: Icon(CupertinoIcons.gear_solid),
    label: 'Settings',
    initialLocation: Routes.settings,
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
