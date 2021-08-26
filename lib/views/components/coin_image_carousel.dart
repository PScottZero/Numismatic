import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:numismatic/model/coin.dart';

class CoinImageCarousel extends StatefulWidget {
  final Coin coin;

  const CoinImageCarousel(this.coin);

  @override
  _CoinImageCarouselState createState() => _CoinImageCarouselState(coin);
}

class _CoinImageCarouselState extends State<CoinImageCarousel> {
  final Coin coin;

  _CoinImageCarouselState(this.coin);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
      ),
      items: (coin.images ?? ['no-image.png']).map(
        (image) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: image != 'no-image.png'
                    ? Image.network(
                        image,
                        errorBuilder: (context, exception, stackTrace) {
                          return Image(
                            image: AssetImage('assets/images/no-image.png'),
                          );
                        },
                      )
                    : Image(
                        image: AssetImage('assets/images/no-image.png'),
                      ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
