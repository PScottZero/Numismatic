import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

import 'you_nav_bar_item.dart';

class NavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  final bool cameraIsInitialized;

  const NavigationBar({
    required this.onTap,
    required this.selectedIndex,
    required this.cameraIsInitialized,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? ViewConstants.colorBackgroundAccent
              : ViewConstants.colorBackgroundAccentLight,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      fixedColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ViewConstants.colorAccent
          : Colors.black,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      items: [
            YouNavBarItem.generate(
              label: 'Collection',
              icon: Icons.grid_view,
              activeIcon: Icons.grid_view_sharp,
            ),
            YouNavBarItem.generate(
              label: 'Collection',
              icon: Icons.favorite_outline,
              activeIcon: Icons.favorite,
            ),
          ] +
          (cameraIsInitialized
              ? [
                  YouNavBarItem.generate(
                    label: 'Camera',
                    icon: Icons.camera_outlined,
                    activeIcon: Icons.camera,
                  ),
                ]
              : []),
    );
  }
}