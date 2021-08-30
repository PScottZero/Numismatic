import 'package:flutter/material.dart';

class ViewConstants {
  // colors
  static Color primaryColor = Colors.blue[300]!;
  static Color warningColor = Colors.red[400]!;

  // text sizing
  static const fontLarge = 28.0;
  static const fontMedium = 22.0;
  static const fontSmall = 18.0;
  static const lineHeight = 1.5;

  // ui sizing
  static const gridGap = 10.0;
  static const gridColumnCount = 2;
  static paddingAllLarge({bool top = true}) =>
      EdgeInsets.fromLTRB(20, top ? 20 : 0, 20, 20);
  static const paddingAllMedium = EdgeInsets.all(15);
  static const paddingAllSmall = EdgeInsets.all(10);
  static const gapSmall = 10.0;
  static const gapLarge = 20.0;
}
