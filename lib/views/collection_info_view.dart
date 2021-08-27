import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/detail.dart';
import 'package:provider/provider.dart';

class CollectionInfoView extends StatelessWidget {
  String collectionValue(CoinCollectionModel model) {
    if (model.collection.length > 0) {
      var mapped = model.collection
          .map(
            (e) => double.tryParse(
              e.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
            ),
          )
          .toList();
      var reduced =
          mapped.reduce((sum, element) => (sum ?? 0) + (element ?? 0));
      return '\$${reduced?.toStringAsFixed(2) ?? 0.0}';
    }
    return '\$0.00';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Collection Info',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
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
