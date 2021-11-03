import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:tflite/tflite.dart';

class CoinClassifier {
  bool _modelLoaded = false;

  CoinClassifier() {
    _loadModel();
  }

  void _loadModel() async {
    try {
      String? res = await Tflite.loadModel(
        model: "assets/coin_classifier.tflite",
        labels: "assets/coin_classifier_labels.txt",
      );
      _modelLoaded = true;
      print(res);
    } catch (e) {
      print('Failed to load model!');
    }
  }

  Future<String> predict(Image image) async {
    if (_modelLoaded) {
      var predictions = await Tflite.runModelOnBinary(
        binary: imageToByteListUint8(image, 128),
      );
      print(predictions);
      return predictions?[0]['label'] ?? 'Failure!';
    }
    return 'Model is not loaded!';
  }

  Uint8List imageToByteListUint8(Image image, int inputSize) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = getRed(pixel) / 255;
        buffer[pixelIndex++] = getGreen(pixel) / 255;
        buffer[pixelIndex++] = getBlue(pixel) / 255;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
