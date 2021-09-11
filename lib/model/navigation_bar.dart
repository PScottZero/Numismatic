import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

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
      selectedItemColor: ViewConstants.colorPrimary,
      items: cameraIsInitialized
          ? [
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view,
                ),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
                ),
                label: 'Wantlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 2 ? Icons.camera : Icons.camera_outlined,
                ),
                label: 'Camera',
              ),
            ]
          : [
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 0 ? Icons.grid_view_sharp : Icons.grid_view,
                ),
                label: 'Collection',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
                ),
                label: 'Wantlist',
              ),
            ],
    );
  }
}
