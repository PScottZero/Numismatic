import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/views/main_view/main_view.dart';
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

MaterialColor generatePrimarySwatch() {
  var colorMap = {50: Colors.lightBlue[200]!};
  for (var i = 100; i <= 900; i += 100) {
    colorMap[i] = Colors.lightBlue[200]!;
  }
  return MaterialColor(0xff62f0e2, colorMap);
}

class NumismaticApp extends StatelessWidget {
  final CameraDescription? _camera;

  ThemeData themeOfBrightness(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: generatePrimarySwatch(),
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
