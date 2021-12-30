import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/services/coin_classifier.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  const CameraView({required this.camera, Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String _currentPrediction = 'N/A';

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
      final result = await _controller.takePicture();
      var image = img.decodeImage(await File(result.path).readAsBytes())!;
      final y = (image.height - image.width) ~/ 2;
      image = img.copyCrop(image, 0, y, image.width, image.width);
      image = img.copyResize(image, width: 224, height: 224);
      var prediction = await CoinClassifier.predict(image);

      setState(() {
        _currentPrediction = prediction;
      });
    } catch (e) {
      return;
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
                                child: CameraPreview(_controller),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(_currentPrediction),
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
