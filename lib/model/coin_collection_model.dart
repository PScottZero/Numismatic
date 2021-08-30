import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin.dart';
import 'coin_type.dart';

const String ALL_COINS_KEY = 'coins';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> allCoins = [];
  List<Coin> get collection =>
      allCoins.where((element) => element.inCollection).toList();
  List<Coin> get wantlist =>
      allCoins.where((element) => !element.inCollection).toList();
  List<CoinType> coinTypes = [];
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;

  String? lastCoinType;
  String? lastVariation;

  CoinCollectionModel() {
    loadTypes();
    loadGreysheetStaticData();
    loadCoins();
  }

  List<String> get allCoinTypes =>
      greysheetStaticData?.keys
          .map((e) => CoinType.coinTypeFromString(e)?.name ?? e)
          .toList() ??
      [];

  loadTypes() async {
    coinTypes = await CoinType.coinTypesFromJson;
    CoinType.coinTypes = coinTypes;
    notifyListeners();
  }

  loadGreysheetStaticData() async {
    greysheetStaticData = Map<String, Map<String, dynamic>>.from(jsonDecode(
      await rootBundle.loadString('assets/json/static-greysheet-data.json'),
    )).map(
      (type, variants) => MapEntry(
        type,
        variants.map(
          (variant, dataJson) => MapEntry(
            variant,
            GreysheetStaticData.fromJson(dataJson),
          ),
        ),
      ),
    );
    notifyListeners();
  }

  loadCoins() async {
    var preferences = await SharedPreferences.getInstance();
    allCoins = jsonDecode(preferences.getString('coins') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList() as List<Coin>;
    notifyListeners();
  }

  saveCoins() async {
    allCoins.sort((a, b) => a.fullType.compareTo(b.fullType));
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'coins',
      jsonEncode(allCoins.map((e) => e.toJson()).toList()),
    );
  }

  addCoin(Coin coin) {
    allCoins.add(coin);
    saveCoins();
    notifyListeners();
  }

  deleteCoin(Coin coin) {
    allCoins.remove(coin);
    saveCoins();
    notifyListeners();
  }

  toggleInCollection(Coin coin) {
    coin.inCollection = !coin.inCollection;
    saveCoins();
    notifyListeners();
  }

  refresh() => notifyListeners();
}
