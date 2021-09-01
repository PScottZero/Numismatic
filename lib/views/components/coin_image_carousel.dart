import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoinImageCarousel extends StatefulWidget {
  final int coinIndex;

  const CoinImageCarousel(this.coinIndex);

  @override
  _CoinImageCarouselState createState() => _CoinImageCarouselState();
}

class _CoinImageCarouselState extends State<CoinImageCarousel> {
  var _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        var coin = model.coinAtIndex(widget.coinIndex);
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, _) => setState(() {
                  _imageIndex = index;
                }),
              ),
              items: (coin?.images ?? ['no-image.png']).map(
                (image) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    padding: ViewConstants.paddingAllLarge(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: ViewConstants.borderRadiusLarge,
                        boxShadow: ViewConstants.dropShadow,
                      ),
                      child: ClipRRect(
                        borderRadius: ViewConstants.borderRadiusLarge,
                        clipBehavior: Clip.antiAlias,
                        child: image != 'no-image.png'
                            ? Image.memory(base64Decode(image))
                            : Image(
                                image: AssetImage('assets/images/no-image.png'),
                              ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
            (coin?.images?.length ?? 0) > 0
                ? AnimatedSmoothIndicator(
                    activeIndex: _imageIndex < 0 ? 0 : _imageIndex,
                    count: coin?.images?.length ?? 0,
                    effect: ColorTransitionEffect(
                      spacing: ViewConstants.dotSpacing,
                      radius: ViewConstants.dotSize,
                      dotWidth: ViewConstants.dotSize,
                      dotHeight: ViewConstants.dotSize,
                      dotColor: ViewConstants.colorInactive,
                      activeDotColor: ViewConstants.colorPrimary,
                    ),
                  )
                : Container(),
            SizedBox(height: ViewConstants.gapSmall),
          ],
        );
      },
    );
  }
}
