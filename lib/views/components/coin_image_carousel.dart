import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/views/components/network_image.dart' as custom;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CoinImageCarousel extends StatefulWidget {
  final Coin coin;

  const CoinImageCarousel(this.coin);

  @override
  _CoinImageCarouselState createState() => _CoinImageCarouselState(coin);
}

class _CoinImageCarouselState extends State<CoinImageCarousel> {
  final Coin coin;
  var _imageIndex = 0;

  _CoinImageCarouselState(this.coin);

  @override
  Widget build(BuildContext context) {
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
          items: (coin.images ?? ['no-image.png']).map(
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
                        ? custom.NetworkImage(image)
                        : Image(
                            image: AssetImage('assets/images/no-image.png'),
                          ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
        AnimatedSmoothIndicator(
          activeIndex: _imageIndex,
          count: coin.images?.length ?? 0,
          effect: ColorTransitionEffect(
            spacing: ViewConstants.dotSpacing,
            radius: ViewConstants.dotSize,
            dotWidth: ViewConstants.dotSize,
            dotHeight: ViewConstants.dotSize,
            dotColor: ViewConstants.colorInactive,
            activeDotColor: ViewConstants.colorPrimary,
          ),
        ),
        SizedBox(height: ViewConstants.gapSmall),
      ],
    );
  }
}
