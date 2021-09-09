import 'package:flutter/material.dart';

class ViewConstants {
  static const String pcgsUrl = 'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/';

  // colors
  static const colorCardTitle = Color(0x77000000);
  static final colorPrimary = Colors.teal[600]!;
  static final colorPrimarySwatch = Colors.teal;
  static final colorSearchBar = Colors.teal[400]!;
  static const colorShadow = Color(0x77000000);
  static final colorWarning = Colors.red[400]!;

  // text sizing
  static const fontLarge = 28.0;
  static const fontMedium = 22.0;
  static const fontSmall = 18.0;
  static const fontMini = 14.0;
  static const spacing1_5 = 1.5;
  static const spacingDouble = 2.0;

  // ui sizing
  static final borderRadiusLarge = BorderRadius.circular(20);
  static final borderRadiusMedium = BorderRadius.circular(15);
  static final borderRadiusSmall = BorderRadius.circular(10);
  static const cardElevation = 5.0;
  static const cardTitleMargin = EdgeInsets.all(10);
  static const cardTitleMaxHeight = 100.0;
  static const cardTitlePadding = EdgeInsets.fromLTRB(10, 5, 10, 5);
  static const detailPadding = EdgeInsets.fromLTRB(15, 15, 15, 18);
  static const gapLarge = 20.0;
  static const gapSmall = 10.0;
  static const gridColumnCount = 2;
  static const iconSize = 30.0;
  static const imageNumberPadding = EdgeInsets.fromLTRB(10, 0, 10, 5);
  static const imageSelectorHeight = 180.0;
  static const leftPaddingLarge = EdgeInsets.only(left: 10);
  static const leftPaddingSmall = EdgeInsets.only(left: 5);
  static const loadingDialogTextHeight = 160.0;
  static const paddingAllLarge = EdgeInsets.all(20);
  static const paddingAllLargeNoTop = EdgeInsets.fromLTRB(20, 0, 20, 20);
  static const paddingAllMedium = EdgeInsets.all(15);
  static const paddingAllSmall = EdgeInsets.all(10);
  static const progressIndicatorSize = 40.0;
  static const radioButtonSize = 18.0;
  static const rightPaddingLarge = EdgeInsets.only(right: 10);
  static const searchBarContentPadding = EdgeInsets.fromLTRB(50, 10, 10, 10);
  static const searchBarPadding = EdgeInsets.fromLTRB(20, 10, 20, 10);
  static const searchBarPreferredSize = Size(double.infinity, 70);
  static const shadowBlurRadius = 8.0;

  // decorations
  static decorationInput(Brightness brightness) => InputDecoration(
        filled: true,
        fillColor:
            brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300],
        contentPadding: ViewConstants.paddingAllMedium,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ViewConstants.colorPrimary,
            width: 2.0,
          ),
          borderRadius: ViewConstants.borderRadiusMedium,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: ViewConstants.borderRadiusMedium,
        ),
      );
}
