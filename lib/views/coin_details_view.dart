import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/client/PCGSClient.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/currency_symbol.dart';

import 'components/detail.dart';

class CoinDetailsView extends StatefulWidget {
  final Coin coin;

  const CoinDetailsView(this.coin, {Key? key}) : super(key: key);

  @override
  _CoinDetailsViewState createState() => _CoinDetailsViewState(this.coin);
}

class _CoinDetailsViewState extends State<CoinDetailsView> {
  final Coin coin;
  int _coinValue = 0;

  _CoinDetailsViewState(this.coin) {
    PCGSClient.coinValue(coin).then(
      (value) => setState(() => _coinValue = value),
    );
    PCGSClient.coinValue(coin).then(
      (value) => setState(() => print(value)),
    );
  }

  String? get denomination {
    if (coin.currencySymbol == CurrencySymbol.CENT) {
      return '${coin.denomination}${coin.currencySymbol?.symbol}';
    } else if (coin.currencySymbol != CurrencySymbol.UNKNOWN) {
      return '${coin.currencySymbol?.symbol}${coin.denomination}';
    } else {
      return null;
    }
  }

  Color get gradeColor {
    final gradeSplit = (coin.grade ?? '').split('-');
    if (gradeSplit.length >= 2) {
      int gradeValue = int.tryParse(gradeSplit[1]) ?? 0;
      if (gradeValue < 10) {
        return Colors.red;
      } else if (gradeValue < 50) {
        return Colors.orange;
      } else if (gradeSplit[0] != 'PR') {
        return Colors.green;
      } else {
        return Colors.blue;
      }
    }
    return Colors.white;
  }

  Color get compositionColor {
    if (coin.composition != null) {
      switch (coin.composition) {
        case 'Gold':
          return Colors.yellow;
        case 'Silver':
          return Colors.grey;
        case 'Nickel':
          return Colors.blueGrey[400]!;
        case 'Copper':
          return Colors.brown[400]!;
        default:
          return Colors.white;
      }
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          coin.type,
          style: GoogleFonts.comfortaa(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 0.88,
              enableInfiniteScroll: false,
            ),
            items: (coin.images ?? []).map(
              (image) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: AssetImage(
                        'assets/images/$image',
                      ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.type,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                Detail('Grade', coin.grade, color: gradeColor),
                Detail('Year', coin.year),
                Detail('Mint Mark', coin.mintMark),
                Detail('Denomination', denomination),
                Detail(
                  'Composition',
                  coin.composition,
                  color: compositionColor,
                ),
                coin.manualValue != null
                    ? Detail(
                        'Price',
                        '\$${(coin.manualValue ?? 0).toStringAsFixed(2)}',
                      )
                    : Detail('Value', _coinValue >= 0 ? '\$$_coinValue' : null)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
