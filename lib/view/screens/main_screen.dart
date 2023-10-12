import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musicplayer/utils/message.dart';
import 'package:musicplayer/utils/route/routes.dart';
import 'package:musicplayer/view/widgets/appbar_main.dart';
import 'package:musicplayer/view/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.location, required this.child});
  final String location;
  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    _selectedIndex = switch (widget.location) {
      Routes.library => 1,
      Routes.settings => 2,
      _ => 0
    };
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBarMain(currentIndex: _selectedIndex),
        body: SafeArea(child: widget.child),
        bottomNavigationBar: BottomNavBar(
            selectedIndex: _selectedIndex,
            onTap: (index) => onChangeTab(index)),
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
