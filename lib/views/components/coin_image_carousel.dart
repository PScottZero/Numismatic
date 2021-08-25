import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/pcgs_photograde_request.dart';

class CoinImageCarousel extends StatefulWidget {
  final Coin coin;

  const CoinImageCarousel(this.coin);

  @override
  _CoinImageCarouselState createState() => _CoinImageCarouselState(coin);
}

class _CoinImageCarouselState extends State<CoinImageCarousel> {
  final Coin coin;
  List<Uint8List>? _pcgsImages;

  _CoinImageCarouselState(this.coin) {
    if (this.coin.images == null) {
      http
          .post(
            Uri.parse(
              "http://numismatic-coin-info-service.us-east-2.elasticbeanstalk.com/coin/images",
            ),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode(PCGSPhotogradeRequest.fromCoin(coin)),
          )
          .then(
            (response) => {
              if (response.statusCode == 200)
                {
                  setState(
                    () {
                      _pcgsImages = (jsonDecode(response.body) as List)
                          .map((e) => Base64Decoder().convert(e))
                          .toList();
                      if (_pcgsImages!.length != 2) {
                        _pcgsImages = null;
                      }
                    },
                  )
                }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
      ),
      items: (coin.images ?? _pcgsImages ?? ['no-image.png']).map(
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
                  child: coin.images == null && _pcgsImages != null
                      ? Image.memory(image as Uint8List)
                      : Image(
                          image:
                              AssetImage('assets/images/${image as String}'))),
            ),
          );
        },
      ).toList(),
    );
  }
}
