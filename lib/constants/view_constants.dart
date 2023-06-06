import 'package:flutter/material.dart';

class ViewConstants {
  // colors
  static const imageTextBackgroundColor = Color(0x77000000);
  static final warningColor = Colors.red[500]!;

  // text sizing
  static const largeFont = 22.0;
  static const mediumFont = 18.0;
  static const smallFont = 14.0;

  // border radii
  static final largeBorderRadius = BorderRadius.circular(20);
  static final mediumBorderRadius = BorderRadius.circular(15);
  static final smallBorderRadius = BorderRadius.circular(10);

  // margins and paddings
  static const largePadding = EdgeInsets.all(20);
  static const mediumPadding = EdgeInsets.all(15);
  static const smallPadding = EdgeInsets.all(10);

  // sizing
  static const gapLarge = 20.0;
  static const gapSmall = 10.0;
  static const iconSize = 30.0;

  // decorations
  static decorationInput(BuildContext context) => InputDecoration(
        filled: true,
        contentPadding: ViewConstants.mediumPadding,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0),
          borderRadius: ViewConstants.mediumBorderRadius,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: ViewConstants.mediumBorderRadius,
        ),
      );
  static const boxShadow = [
    BoxShadow(
      color: Color(0x77000000),
      spreadRadius: 0,
      blurRadius: 2,
    )
  ];
}
