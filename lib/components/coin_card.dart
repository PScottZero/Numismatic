import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/coin_details_view.dart';
import 'package:provider/provider.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  const CoinCard(this.coin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) => GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoinDetailsView(coin),
            ),
          ),
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: ViewConstants.largeBorderRadius,
            boxShadow: ViewConstants.boxShadow,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              coin.images != null && coin.images![0] != 'no-image.png'
                  ? Image.memory(
                      base64Decode(coin.images![0]),
                    )
                  : const Image(
                      image: AssetImage('assets/images/no-image.png'),
                    ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  minHeight: 0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: ViewConstants.smallBorderRadius,
                    color: ViewConstants.imageTextBackgroundColor,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    coin.fullType,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: ViewConstants.smallFont,
                      color: Colors.white,
                    ),
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
