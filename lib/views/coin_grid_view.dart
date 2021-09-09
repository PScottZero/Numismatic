import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numismatic/components/coin_card.dart';
import 'package:numismatic/components/count_and_value.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/coin.dart';
import 'package:numismatic/model/coin_collection_model.dart';
import 'package:provider/provider.dart';

class CoinGridView extends StatefulWidget {
  final bool isWantlist;

  const CoinGridView({this.isWantlist = false, Key? key}) : super(key: key);

  @override
  _CoinGridViewState createState() => _CoinGridViewState();
}

class _CoinGridViewState extends State<CoinGridView> {
  CoinCollectionModel? _model;

  String get title => widget.isWantlist ? 'Wantlist' : 'Collection';
  List<Coin> get coins => widget.isWantlist
      ? _model?.wantlist
              .where(
                  (e) => e.fullType.contains(_model?.searchString.value ?? ''))
              .toList() ??
          []
      : _model?.collection
              .where(
                  (e) => e.fullType.contains(_model?.searchString.value ?? ''))
              .toList() ??
          [];

  bool get searchStringNonEmpty => (_model?.searchString.value.length ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinCollectionModel>(
      builder: (context, model, child) {
        _model = model;
        return coins.isNotEmpty || searchStringNonEmpty
            ? GridView.count(
                crossAxisCount: ViewConstants.gridColumnCount,
                mainAxisSpacing: ViewConstants.gapLarge,
                crossAxisSpacing: ViewConstants.gapLarge,
                padding: ViewConstants.paddingAllLarge,
                childAspectRatio: 1,
                children: (searchStringNonEmpty
                        ? <Widget>[]
                        : <Widget>[CountAndValue(coins)]) +
                    coins.map((e) => CoinCard(e)).toList(),
              )
            : Container(
                padding: ViewConstants.paddingAllLarge,
                child: Center(
                  child: Text(
                    'Press + to add a coin to your ${widget.isWantlist ? 'wantlist' : 'collection'}',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
      },
    );
  }
}
