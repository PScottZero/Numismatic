import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

// code adapted from https://github.com/am15h/tflite_flutter_helper/blob/master/example/image_classification/lib/classifier.dart
class CoinClassifier {
  late Interpreter _interpreter;
  late List<String> _labels;
  bool _modelLoaded = false;
  bool _labelsLoaded = false;

  CoinClassifier() {
    _loadModel();
    _loadLabels();
  }

  Future<void> _loadModel() async {
    _interpreter =
        await Interpreter.fromAsset('classifier/coin_classifier.tflite');
    _modelLoaded = true;
  }

  Future<void> _loadLabels() async {
    _labels = await FileUtil.loadLabels('assets/classifier/labels.txt');
    _labelsLoaded = true;
  }

  void predict(img.Image image) {
    if (_modelLoaded && _labelsLoaded) {
      var inputImage = TensorImage();
      inputImage.loadImage(image);
      inputImage = ImageProcessorBuilder()
          .add(ResizeOp(224, 224, ResizeMethod.NEAREST_NEIGHBOUR))
          .add(NormalizeOp(0, 255))
          .build()
          .process(inputImage);
      var outputBuffer = TensorBuffer.createFixedSize(
          _interpreter.getOutputTensor(0).shape,
          _interpreter.getOutputTensor(0).type);
      _interpreter.run(inputImage.buffer, outputBuffer.getBuffer());
      Map<String, double> labeledProb =
          TensorLabel.fromList(_labels, outputBuffer).getMapWithFloatValue();
      print(labeledProb);
    }
  }
}
