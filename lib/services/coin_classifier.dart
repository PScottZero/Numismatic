import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:tflite/tflite.dart';

class CoinClassifier {
  static bool modelLoaded = false;

  static Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/coin_classifier.tflite',
      labels: 'assets/coin_classifier_labels.txt',
    );
  }

  static Future<String> predict(img.Image image) async {
    if (!modelLoaded) {
      await loadModel();
      modelLoaded = true;
    }
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(image, 256, 0, 255.0),
    );
    return recognitions?[0]['label'] ?? '';
  }

  // code from https://pub.dev/packages/tflite
  static Uint8List imageToByteListFloat32(
    img.Image image,
    int inputSize,
    double mean,
    double std,
  ) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
}
