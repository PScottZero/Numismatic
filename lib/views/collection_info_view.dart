import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/components/detail.dart';
import 'package:provider/provider.dart';

class CollectionInfoView extends StatelessWidget {
  const CollectionInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Detail(
                name: 'Collection Value',
                value: model.collection
                        .map(
                          (e) => double.tryParse(
                            e.retailPrice?.replaceAll('\$', '') ?? '',
                          ),
                        )
                        .reduce((sum, element) => (sum ?? 0) + (element ?? 0))
                        ?.toStringAsFixed(2) ??
                    '\$0.00',
              ),
            ],
          ),
        );
      },
    );
  }
}
