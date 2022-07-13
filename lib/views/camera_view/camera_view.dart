import 'dart:async';
import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/components/rounded_button.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/services/coin_classifier.dart';
import 'package:numismatic/views/camera_view/components/prediction_view.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  const CameraView({required this.camera, Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late CoinClassifier _classifier;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _classifier = CoinClassifier();
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
      _classifier.predict(image);
      showModalBottomSheet(
        context: context,
        builder: (context) => const PredictionView('morgan'),
        backgroundColor: ViewConstants.backgroundColorFromContext(context),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      );
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
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
