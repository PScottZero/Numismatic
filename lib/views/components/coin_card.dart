import 'package:numismatic/model/coin.dart';
import 'package:numismatic/views/coin_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  CoinCard(this.coin);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CoinDetails(coin)))
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: AssetImage(
                'assets/images/${coin.images?[0] ?? 'coin.jpg'}',
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0x99000000),
              ),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              margin: EdgeInsets.all(10),
              child: Text(
                coin.type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
