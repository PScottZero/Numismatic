import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin_type.dart';
import 'coin.dart';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> collection = [];
  List<CoinType> coinTypes = [];
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;

  CoinCollectionModel() {
    loadTypes();
    loadGreysheetStaticData();
    loadCollection();
  }

  List<String> get allCoinTypes =>
      greysheetStaticData?.keys
          .map((e) => CoinType.coinTypeFromString(e, coinTypes)?.name ?? e)
          .toList() ??
      [];

  List<String> variationsFromCoinType(String type) =>
      greysheetStaticData?[type]?.keys.toList() ?? [];

  loadTypes() async {
    coinTypes = await CoinType.coinTypesFromJson;
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

  loadCollection() async {
    var preferences = await SharedPreferences.getInstance();
    collection = jsonDecode(preferences.getString('collection') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList();
    notifyListeners();
  }

  saveCollection() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'collection',
      jsonEncode(collection.map((e) => e.toJson()).toList()),
    );
    collection = jsonDecode(preferences.getString('collection') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList();
    notifyListeners();
  }

  addCoin(Coin coin) {
    collection.add(coin);
    saveCollection();
    notifyListeners();
  }

  deleteCoin(Coin coin) {
    collection.remove(coin);
    saveCollection();
    notifyListeners();
  }

  refresh() => notifyListeners();
}
