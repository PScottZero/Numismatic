import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:numismatic/components/custom_scaffold.dart';
import 'package:numismatic/constants/view_constants.dart';

class CoinClassifierView extends StatefulWidget {
  final img.Image image;
  final String label;

  const CoinClassifierView(this.image, this.label, {Key? key})
      : super(key: key);

  @override
  _CoinClassifierViewState createState() => _CoinClassifierViewState();
}

class _CoinClassifierViewState extends State<CoinClassifierView> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: 'Coin ID',
      body: ListView(
        children: [
          Image.memory(Uint8List.fromList(img.encodePng(widget.image))),
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: ViewConstants.largeFont,
            ),
          )
        ],
      ),
    );
  }
}
