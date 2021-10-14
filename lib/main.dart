import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/main_view.dart';
import 'package:provider/provider.dart';

import 'model/coin_collection_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CoinCollectionModel(context),
      child: NumismaticApp(cameras.isNotEmpty ? cameras.first : null),
    ),
  );
}

class NumismaticApp extends StatelessWidget {
  final CameraDescription? _camera;

  ThemeData themeOfBrightness(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xff62f0e2,
            {
              50: Color(0xff62f0e2),
              100: Color(0xff62f0e2),
              200: Color(0xff62f0e2),
              300: Color(0xff62f0e2),
              400: Color(0xff62f0e2),
              500: Color(0xff62f0e2),
              600: Color(0xff62f0e2),
              700: Color(0xff62f0e2),
              800: Color(0xff62f0e2),
              900: Color(0xff62f0e2),
            },
          ),
        ).copyWith(
          secondary: ViewConstants.primaryColor,
          brightness: brightness,
        ),
        textTheme: GoogleFonts.quicksandTextTheme(
          const TextTheme(
            bodyText2: TextStyle(
              fontSize: ViewConstants.largeFont,
              height: 1.5,
            ),
          ),
        ),
      );

  const NumismaticApp(this._camera, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numismatic',
      debugShowCheckedModeBanner: false,
      theme: themeOfBrightness(Brightness.light),
      darkTheme: themeOfBrightness(Brightness.dark),
      home: MainView(_camera),
    );
  }
}
