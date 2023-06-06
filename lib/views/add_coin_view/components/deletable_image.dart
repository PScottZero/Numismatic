import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';

class DeletableImage extends StatelessWidget {
  final Uint8List image;
  final VoidCallback onDelete;

  const DeletableImage({
    required this.image,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: ViewConstants.mediumBorderRadius,
          child: Image.memory(image),
        ),
        IconButton(
          color: Colors.red,
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            size: ViewConstants.iconSize,
          ),
        )
      ],
    );
  }
}
