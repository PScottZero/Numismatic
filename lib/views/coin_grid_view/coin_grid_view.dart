import 'package:flutter/material.dart';
import 'package:numislog/constants/view_constants.dart';
import 'package:numislog/model/coin.dart';
import 'package:numislog/model/app_model.dart';
import 'package:provider/provider.dart';

import 'components/coin_card.dart';
import 'components/count_and_value.dart';

class CoinGridView extends StatefulWidget {
  final bool isWantlist;

  const CoinGridView({this.isWantlist = false, Key? key}) : super(key: key);

  @override
  State<CoinGridView> createState() => _CoinGridViewState();
}

class _CoinGridViewState extends State<CoinGridView> {
  AppModel? _model;

  String get title => widget.isWantlist ? 'Wantlist' : 'Collection';

  bool get searchStringNonEmpty => (_model?.searchString.value.length ?? 0) > 0;

  List<Coin> get coins => widget.isWantlist
      ? filterBySearchString(_model?.wantlist)
      : filterBySearchString(_model?.collection);

  List<Coin> filterBySearchString(List<Coin>? coins) =>
      coins
          ?.where((coin) =>
              coin.description.contains(_model?.searchString.value ?? ''))
          .toList() ??
      [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, model, child) {
        _model = model;
        return coins.isNotEmpty || searchStringNonEmpty
            ? GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: ViewConstants.gapSmall,
                crossAxisSpacing: ViewConstants.gapSmall,
                padding: ViewConstants.smallPadding,
                childAspectRatio: 1,
                children: (searchStringNonEmpty
                        ? <Widget>[]
                        : <Widget>[CountAndValue(coins)]) +
                    coins.map((e) => CoinCard(e)).toList(),
              )
            : Container(
                padding: ViewConstants.largePadding,
                child: Center(
                  child: Text(
                    model.isLoading
                        ? 'Loading ${widget.isWantlist ? 'wantlist' : 'collection'}...'
                        : 'No coins in ${widget.isWantlist ? 'wantlist' : 'collection'}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: ViewConstants.largeFont),
                  ),
                ),
              );
      },
    );
  }
}
