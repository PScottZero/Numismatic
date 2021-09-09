import 'package:flutter/material.dart';

class ViewConstants {
  static const String pcgsUrl = 'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/';

  // colors
  static final Color colorButton = Colors.blue[400]!;
  static const Color colorCardTitle = Color(0x77000000);
  static final Color colorInactiveLight = Colors.grey[300]!;
  static final Color colorInactiveDark = Colors.grey[500]!;
  static final Color colorPrimary = Colors.blueGrey[400]!;
  static final Color colorWarning = Colors.red[400]!;

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
  static const borderWidthFocused = 2.0;
  static const borderWidthUnfocused = 1.0;
  static const cardTitleMargin = EdgeInsets.all(10);
  static const cardTitleMaxHeight = 100.0;
  static const cardTitlePadding = EdgeInsets.fromLTRB(10, 5, 10, 5);
  static decorationInput(Brightness brightness) => InputDecoration(
        filled: true,
        fillColor:
            brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300],
        contentPadding: ViewConstants.paddingAllMedium,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ViewConstants.colorPrimary,
            width: ViewConstants.borderWidthFocused,
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
  static const dotSize = 8.0;
  static const dotSpacing = 8.0;
  static const gapLarge = 20.0;
  static const gapMedium = 15.0;
  static const gapSmall = 10.0;
  static const gridColumnCount = 2;
  static const gridGap = 10.0;
  static paddingAllLarge({bool top = true}) =>
      EdgeInsets.fromLTRB(20, top ? 20 : 0, 20, 20);
  static const paddingAllMedium = EdgeInsets.all(15);
  static const paddingAllSmall = EdgeInsets.all(10);
  static const radioButtonSize = 18.0;
}
