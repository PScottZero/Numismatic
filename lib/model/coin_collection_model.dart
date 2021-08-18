import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin.dart';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> collection = [];

  CoinCollectionModel() {
    initForTesting();
  }

  initForTesting() async {
    collection = jsonDecode(
      await rootBundle.loadString('assets/test_collection.json'),
    ).map<Coin>((e) => Coin.fromJson(e)).toList();
    notifyListeners();
  }

  loadCollection() async {
    var preferences = await SharedPreferences.getInstance();
    collection = jsonDecode(preferences.getString('collection') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList();
    notifyListeners();
  }

  addCoin(Coin coin) {
    collection.add(coin);
    notifyListeners();
  }
}
