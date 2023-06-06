import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageCarousel extends StatelessWidget {
  final List<String>? images;

  const ImageCarousel(this.images, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: PageView(
        children: (images ?? ['no-image.png']).map(
          (image) {
            var index = (images?.indexOf(image) ?? 0) + 1;
            return Container(
              margin: ViewConstants.largePadding,
              decoration: BoxDecoration(
                borderRadius: ViewConstants.largeBorderRadius,
                boxShadow: ViewConstants.boxShadow,
              ),
              child: ClipRRect(
                borderRadius: ViewConstants.largeBorderRadius,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      color: Colors.black,
                      child: PinchZoom(
                        maxScale: 3,
                        child: image != 'no-image.png'
                            ? Image.memory(base64Decode(image))
                            : const Image(
                                image: AssetImage('assets/images/no-image.png'),
                              ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                      margin: ViewConstants.smallPadding,
                      decoration: BoxDecoration(
                        color: ViewConstants.imageTextBackgroundColor,
                        borderRadius: ViewConstants.smallBorderRadius,
                      ),
                      child: Text(
                        '$index of ${images?.length ?? 1}',
                        style: const TextStyle(
                          fontSize: ViewConstants.smallFont,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
