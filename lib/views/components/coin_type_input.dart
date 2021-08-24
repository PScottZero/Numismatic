import 'package:flutter/material.dart';
import 'package:numismatic/model/coin-type.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/model/multi-source-value.dart';
import 'package:provider/provider.dart';

class CoinTypeInput extends StatelessWidget {
  final Coin coin;

  CoinTypeInput(this.coin) {
    coin.retailPrice = MultiSourceValue(
      urlSource:
          "http://numismatic-coin-info-service.us-east-2.elasticbeanstalk.com/coin/retailPrice",
    );
    coin.mintage = MultiSourceValue(
      urlSource:
          "http://numismatic-coin-info-service.us-east-2.elasticbeanstalk.com/coin/mintage",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Coin Type"),
                Text(
                  "*",
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            SizedBox(height: 10),
            Autocomplete<CoinType>(
              optionsBuilder: (currentText) {
                if (currentText.text == '') {
                  return const Iterable<CoinType>.empty();
                }
                return model.coinTypes.where((option) {
                  return option.name.toLowerCase().contains(
                        currentText.text.toLowerCase(),
                      );
                });
              },
              onSelected: (value) => coin.type = value.name,
              displayStringForOption: (option) => option.name,
              fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => coin.type = value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
