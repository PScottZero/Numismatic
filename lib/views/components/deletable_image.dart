import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';

class DeletableImage extends StatelessWidget {
  final Uint8List image;
  final VoidCallback onDelete;

  const DeletableImage({
    required this.image,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: ViewConstants.borderRadiusMedium,
          child: Image.memory(image),
        ),
        IconButton(
          color: Colors.red,
          onPressed: onDelete,
          icon: Icon(Icons.delete, size: 30),
        )
      ],
    );
  }
}