import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/views/coin_grid_view.dart';
import 'package:provider/provider.dart';

import 'model/coin_collection_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(),
      child: NumismaticApp(),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  ThemeData buildCustomThemeData(ThemeData base) => base.copyWith(
        primaryColor: Colors.cyan,
        textTheme: GoogleFonts.comfortaaTextTheme(
          TextTheme(
            bodyText2: TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      );
  ThemeData buildLightTheme() => buildCustomThemeData(ThemeData.light());
  ThemeData buildDarkTheme() => buildCustomThemeData(ThemeData.dark());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: CoinGridView(),
    );
  }
}
