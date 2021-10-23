// From https://github.com/am15h/tflite_flutter_helper

import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'classifier.dart';

class ClassifierQuant extends Classifier {
  ClassifierQuant({int numThreads = 1}) : super(numThreads: numThreads);

  @override
  String get modelName => 'coin_classifier.tflite';

  @override
  NormalizeOp get preProcessNormalizeOp => NormalizeOp(0, 1);

  @override
  NormalizeOp get postProcessNormalizeOp => NormalizeOp(0, 255);
}
