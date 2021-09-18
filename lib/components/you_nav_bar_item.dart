import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class YouNavBarItem {
  static BottomNavigationBarItem generate({
    required String label,
    required IconData icon,
    required IconData activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(icon),
      ),
      activeIcon: Container(
        width: 70,
        decoration: BoxDecoration(
          color: ViewConstants.colorPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            activeIcon,
            color: ViewConstants.colorAccent,
          ),
        ),
      ),
      label: label,
    );
  }
}
