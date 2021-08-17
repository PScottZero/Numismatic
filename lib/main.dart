import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/coin_collection_model.dart';
import 'views/main_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(),
      child: NumismaticApp(),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.comfortaaTextTheme(
          TextTheme(
            bodyText2: TextStyle(
              color: Colors.white,
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        textTheme: GoogleFonts.comfortaaTextTheme(
          TextTheme(
            bodyText2: TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      ),
      home: MainView(),
    );
  }
}
