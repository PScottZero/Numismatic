import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/currency_symbol.dart';
import 'package:numismatic/views/components/detail.dart';

class CoinDetails extends StatelessWidget {
  final Coin coin;

  CoinDetails(this.coin);

  String? get denomination {
    if (coin.currencySymbol == CurrencySymbol.CENT) {
      return '${coin.denomination}${coin.currencySymbol?.symbol}';
    } else if (coin.currencySymbol != CurrencySymbol.UNKNOWN) {
      return '${coin.currencySymbol?.symbol}${coin.denomination}';
    } else {
      return null;
    }
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
        padding: EdgeInsets.all(30),
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Image(
              image: AssetImage(
                'assets/images/${coin.images?[0] ?? 'coin.jpg'}',
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            coin.type,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          Detail('Year', coin.year),
          Detail('Mint Mark', coin.mintMark),
          Detail('Denomination', denomination),
          Detail('Composition', coin.composition),
        ],
      ),
    );
  }
}
