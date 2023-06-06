import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model/app_model.dart';
import 'views/main_view/main_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(context),
      child: const NumisLogApp(),
    ),
  );
}

class NumisLogApp extends StatelessWidget {
  const NumisLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      ColorScheme lightColorScheme;
      ColorScheme darkColorScheme;

      // set dynamic light and dark schemes
      if (lightDynamic != null && darkDynamic != null) {
        lightColorScheme = lightDynamic.harmonized();
        darkColorScheme = darkDynamic.harmonized();
      } else {
        lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
        darkColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        );
      }

      return MaterialApp(
        title: 'NumisLog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.quicksandTextTheme().apply(
            bodyColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: GoogleFonts.quicksandTextTheme().apply(
            bodyColor: Colors.white,
          ),
        ),
        home: const MainView(),
      );
    });
  }
}
