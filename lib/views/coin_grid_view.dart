import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

import 'components/coin_card.dart';

class CoinGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.all(10),
            children: model.collection.map((e) => CoinCard(e)).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.cyan,
          ),
        );
      },
    );
  }
}
