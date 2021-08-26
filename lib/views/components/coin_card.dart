import 'package:numismatic/model/coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

import '../coin_details_view.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  CoinCard(this.coin);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) => GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinDetailsView(model, coin),
            ),
          ),
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              coin.images != null && coin.images![0] != 'no-image.png'
                  ? Image.network(
                      coin.images![0],
                      errorBuilder: (context, exception, stackTrace) {
                        return Image(
                          image: AssetImage('assets/images/no-image.png'),
                        );
                      },
                    )
                  : Image(
                      image: AssetImage('assets/images/no-image.png'),
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
                  coin.fullType,
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
      ),
    );
  }
}
