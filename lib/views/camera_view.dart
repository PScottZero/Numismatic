import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class CameraView extends StatefulWidget {
  final CameraDescription camera;

  const CameraView({required this.camera, Key? key}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Transform.scale(
              scale: 1,
              child: Padding(
                padding: ViewConstants.paddingAllLarge,
                child: ClipRRect(
                  borderRadius: ViewConstants.borderRadiusLarge,
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
                                width: MediaQuery.of(context).size.width - 100,
                                height: MediaQuery.of(context).size.width - 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width - 100,
                                  ),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: ViewConstants.cameraCircleWidth,
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
