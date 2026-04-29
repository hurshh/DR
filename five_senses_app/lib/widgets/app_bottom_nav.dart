import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum BottomTab { home, learn, play, practice }

class AppBottomNav extends StatelessWidget {
  final BottomTab selectedTab;
  final ValueChanged<BottomTab> onTap;

  const AppBottomNav({
    super.key,
    required this.selectedTab,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final active = AppTheme.orange;
    final inactive = const Color(0xFFB7B7B7);

    BottomTab tabFromIndex(int i) {
      switch (i) {
        case 0:
          return BottomTab.home;
        case 1:
          return BottomTab.learn;
        case 2:
          return BottomTab.play;
        default:
          return BottomTab.practice;
      }
    }

    int indexOf(BottomTab tab) {
      switch (tab) {
        case BottomTab.home:
          return 0;
        case BottomTab.learn:
          return 1;
        case BottomTab.play:
          return 2;
        case BottomTab.practice:
          return 3;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 4,
      currentIndex: indexOf(selectedTab),
      selectedItemColor: active,
      unselectedItemColor: inactive,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (i) => onTap(tabFromIndex(i)),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          activeIcon: Icon(Icons.menu_book_rounded),
          label: 'Learn',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset_outlined),
          activeIcon: Icon(Icons.videogame_asset_rounded),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_outlined),
          activeIcon: Icon(Icons.edit_rounded),
          label: 'Practice',
        ),
      ],
    );
  }
}

