import 'package:flutter/material.dart';

import 'app_bottom_nav.dart';

class FiveSensesScaffold extends StatelessWidget {
  final int selectedTabIndex;
  final Widget body;
  final Color? backgroundColor;
  final bool showBottomNav;
  final BottomTab? bottomTab;
  final ValueChanged<BottomTab> onBottomNavTap;

  const FiveSensesScaffold({
    super.key,
    required this.selectedTabIndex,
    required this.body,
    this.backgroundColor,
    this.showBottomNav = true,
    this.bottomTab,
    required this.onBottomNavTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFFF6EFE3);

    BottomTab tab;
    switch (selectedTabIndex) {
      case 0:
        tab = BottomTab.home;
        break;
      case 1:
        tab = BottomTab.learn;
        break;
      case 2:
        tab = BottomTab.play;
        break;
      default:
        tab = BottomTab.practice;
    }

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        top: false,
        child: body,
      ),
      bottomNavigationBar: showBottomNav
          ? AppBottomNav(
              selectedTab: tab,
              onTap: onBottomNavTap,
            )
          : null,
    );
  }
}

