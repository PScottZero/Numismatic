import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_classifier.dart';
import 'package:numismatic/views/coin_classifier_view.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  const CameraView({required this.camera, Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  var classifier = CoinClassifier();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePhoto() async {
    try {
      // await _initializeControllerFuture;
      // final image = await _controller.takePicture();
      // final decodedImage = decodeImage(await image.readAsBytes());
      // if (decodedImage != null) {
      //   final jpg = encodeJpg(decodedImage);
      //   final croppedImage = copyResizeCropSquare(decodeJpg(jpg), 128);

      //   final res = await rootBundle.load('assets/images/Morgan_o.jpg');
      //   final img = decodeImage(res.buffer.asUint8List());
      //   if (img != null) {
      //     final label = await classifier.predict(img);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => CoinClassifierView(croppedImage, label),
      //       ),
      //     );
      //   }
      // }
      final res = await rootBundle.load('assets/images/Morgan_o.jpg');
      var img = decodeImage(res.buffer.asUint8List());
      print(img!.getPixel(185, 125));
      img = copyResize(img, width: 128, height: 128);
      print(img.getPixel(50, 50));
      final label = await classifier.predict(img);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoinClassifierView(img!, label),
        ),
      );
    } catch (e) {
      // ignore failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Transform.scale(
                    scale: 1,
                    child: Padding(
                      padding: ViewConstants.largePadding,
                      child: ClipRRect(
                        borderRadius: ViewConstants.largeBorderRadius,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: OverflowBox(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CameraPreview(_controller),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      height:
                                          MediaQuery.of(context).size.width -
                                              80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width -
                                              80,
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: RoundedButton(
                    label: 'Identify',
                    onPressed: _takePhoto,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
