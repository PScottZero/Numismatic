import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/detail.dart';
import 'package:provider/provider.dart';

class CollectionInfoView extends StatelessWidget {
  String collectionValue(CoinCollectionModel model) {
    if (model.collection.length > 0) {
      var sum = model.collection
          .map(
            (e) => double.tryParse(
              e.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
            ),
          )
          .toList()
          .reduce((sum, element) => (sum ?? 0) + (element ?? 0));
      return '\$${(sum ?? 0.0).toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Container(
          padding: ViewConstants.paddingAllLarge(),
          child: Center(
            child: ListView(
              children: [
                Text(
                  'Collection Info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ViewConstants.fontLarge,
                    fontWeight: FontWeight.bold,
                    height: ViewConstants.lineHeight,
                  ),
                ),
                Detail(
                  name: 'Coins In Collection',
                  value: model.collection.length.toString(),
                ),
                Detail(
                  name: 'Coins In Wantlist',
                  value: model.wantlist.length.toString(),
                ),
                Detail(
                  name: 'Collection Value',
                  value: collectionValue(model),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
