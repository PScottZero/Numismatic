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

  Coin currentCoin = Coin();

  List<String> get allCoinTypes {
    return greysheetStaticData?.keys
            .map((e) => fromGreysheetString(e)?.name ?? e)
            .toList() ??
        [];
  }

  CoinCollectionModel() {
    loadTypes();
    loadGreysheetStaticData();
    loadCollection();
  }

  CoinType? fromString(String type) {
    var filteredTypes = coinTypes
        .where(
          (element) => element.name == type,
        )
        .toList();
    if (filteredTypes.length != 0) {
      return filteredTypes[0];
    } else {
      return null;
    }
  }

  CoinType? fromGreysheetString(String type) {
    try {
      return coinTypes
          .where((element) => element.getGreysheetName() == type)
          .toList()
          .first;
    } catch (ex) {
      return null;
    }
  }

  loadTypes() async {
    coinTypes = (jsonDecode(
      await rootBundle.loadString('assets/json/coin-types.json'),
    ) as List<dynamic>)
        .map((type) => CoinType.fromJson(type))
        .toList();
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
}
