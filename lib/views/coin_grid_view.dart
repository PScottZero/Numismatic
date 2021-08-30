import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
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
                  crossAxisCount: ViewConstants.gridColumnCount,
                  mainAxisSpacing: ViewConstants.gridGap,
                  crossAxisSpacing: ViewConstants.gridGap,
                  padding: ViewConstants.paddingAllSmall,
                  children: coins.map((e) => CoinCard(e)).toList(),
                )
              : Container(
                  padding: ViewConstants.paddingAllSmall,
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
                  builder: (context) => AddCoinView(
                    addToWantlist: isWantlist,
                    edit: false,
                  ),
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
