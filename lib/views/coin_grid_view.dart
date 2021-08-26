import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:provider/provider.dart';

import 'components/coin_card.dart';

class CoinGridView extends StatelessWidget {
  final bool isWantlist;

  CoinGridView({this.isWantlist = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        var coins = isWantlist ? model.wantlist : model.collection;
        return Scaffold(
          body: coins.length > 0
              ? GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.all(10),
                  children: coins.map((e) => CoinCard(e)).toList(),
                )
              : Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'Press + to add a coin to your ${isWantlist ? 'wantlist' : 'collection'}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCoinView(isWantlist),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
