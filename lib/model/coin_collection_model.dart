import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin-type.dart';
import 'coin.dart';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> collection = [];
  List<CoinType> coinTypes = [];

  CoinCollectionModel() {
    loadTypes();
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

  loadTypes() async {
    coinTypes = jsonDecode(
      await rootBundle.loadString('assets/json/coin-types.json'),
    ).map<CoinType>((e) => CoinType.fromJson(e)).toList();
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
