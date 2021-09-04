import 'package:flutter/material.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:numismatic/views/add_coin_view.dart';
import 'package:numismatic/views/components/coin_card.dart';
import 'package:numismatic/views/components/count_and_value.dart';
import 'package:provider/provider.dart';

class CoinGridView extends StatefulWidget {
  final bool isWantlist;

  const CoinGridView({this.isWantlist = false});

  @override
  _CoinGridViewState createState() => _CoinGridViewState();
}

class _CoinGridViewState extends State<CoinGridView> {
  CoinCollectionModel? _model;

  String get title => widget.isWantlist ? 'Wantlist' : 'Collection';
  List<Coin> get coins =>
      widget.isWantlist ? _model?.wantlist ?? [] : _model?.collection ?? [];

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        var coins = widget.isWantlist ? model.wantlist : model.collection;
        _model = model;
        return Scaffold(
          body: coins.length > 0
              ? GridView.count(
                  crossAxisCount: ViewConstants.gridColumnCount,
                  mainAxisSpacing: ViewConstants.gapLarge,
                  crossAxisSpacing: ViewConstants.gapLarge,
                  padding: ViewConstants.paddingAllLarge(),
                  childAspectRatio: 1,
                  children: <Widget>[CountAndValue(coins)] +
                      coins.map((e) => CoinCard(e)).toList(),
                )
              : Container(
                  padding: ViewConstants.paddingAllLarge(),
                  child: Center(
                    child: Text(
                      'Press + to add a coin to your ${widget.isWantlist ? 'wantlist' : 'collection'}',
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
                    addToWantlist: widget.isWantlist,
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
