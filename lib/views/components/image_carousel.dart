import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String>? images;

  ImageCarousel(this.images);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width - 40,
        aspectRatio: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      items: (images ?? ['no-image.png']).map(
        (image) {
          return image != 'no-image.png'
              ? Image.memory(base64Decode(image))
              : Image(
                  image: AssetImage('assets/images/no-image.png'),
                );
        },
      ).toList(),
    );
  }
}
