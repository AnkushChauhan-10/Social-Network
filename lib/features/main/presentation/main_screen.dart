import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/constants/app_size.dart';
import 'package:social_network/route/app_router.dart';
import 'package:social_network/route/app_routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(this.shell, {super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          currentIndex: shell.currentIndex < 2
              ? shell.currentIndex
              : shell.currentIndex + 1,
          onTap: _goTo,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: AppIconSize.medium),
              activeIcon: Icon(Icons.home, size: AppIconSize.medium),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: AppIconSize.medium),
              activeIcon: Icon(Icons.search, size: AppIconSize.medium),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: AppIconSize.medium),
              activeIcon: Icon(Icons.add_box, size: AppIconSize.medium),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: AppIconSize.medium),
              activeIcon: Icon(Icons.favorite, size: AppIconSize.medium),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined, size: AppIconSize.medium),
              activeIcon: Icon(Icons.person_2, size: AppIconSize.medium),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  void _goTo(int i) async {
    if (i == 2) {
      await AppRouter.push(AppRoutes.createPost);
      i = 0;
    } else if (i > 2) {
      i = i - 1;
    }
    shell.goBranch(i);
  }
}
