import 'package:flutter/material.dart';

class ViewConstants {
  static const String pcgsUrl = 'https://i.pcgs.com/s3/cu-pcgs/Photograde/250/';

  // colors
  static final Color colorButton = Colors.green[300]!;
  static final Color colorCardTitle = Color(0x77000000);
  static final Color colorInactive = Colors.grey[300]!;
  static final Color colorPrimary = Colors.blue[300]!;
  static final Color colorWarning = Colors.red[300]!;

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
  static final borderWidthFocused = 2.0;
  static final borderWidthUnfocused = 1.0;
  static final cardTitleMargin = EdgeInsets.all(10);
  static const cardTitleMaxHeight = 100.0;
  static final cardTitlePadding = EdgeInsets.fromLTRB(10, 5, 10, 5);
  static final decorationInput = InputDecoration(
    contentPadding: ViewConstants.paddingAllLarge(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ViewConstants.colorPrimary,
        width: ViewConstants.borderWidthFocused,
      ),
      borderRadius: ViewConstants.borderRadiusMedium,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: ViewConstants.borderWidthUnfocused,
      ),
      borderRadius: ViewConstants.borderRadiusMedium,
    ),
  );
  static const dotSize = 8.0;
  static const dotSpacing = 8.0;
  static const dropShadow = [
    BoxShadow(
      color: Color(0x22000000),
      blurRadius: 10,
    ),
  ];
  static const gapLarge = 20.0;
  static const gapSmall = 10.0;
  static const gridColumnCount = 2;
  static const gridGap = 10.0;
  static final paddingButton = EdgeInsets.only(top: 20, bottom: 17);
  static paddingAllLarge({bool top = true}) =>
      EdgeInsets.fromLTRB(20, top ? 20 : 0, 20, 20);
  static const paddingAllMedium = EdgeInsets.all(15);
  static const paddingAllSmall = EdgeInsets.all(10);
  static const radioButtonSize = 18.0;
}
