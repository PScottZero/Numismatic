import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin.dart';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> collection = [];

  CoinCollectionModel() {
    initialConfigLoaded().then(
      (initialConfigLoaded) {
        if (!initialConfigLoaded) {
          initForTesting();
        } else {
          loadCollection();
        }
      },
    );
  }

  initForTesting() async {
    var preferences = await SharedPreferences.getInstance();
    collection = jsonDecode(
      await rootBundle.loadString('assets/test_collection.json'),
    ).map((e) => Coin.fromJson(e)).toList();
    preferences.setString('collection', jsonEncode(collection));
    preferences.setBool('initialConfigLoaded', true);
    notifyListeners();
  }

  loadCollection() async {
    var preferences = await SharedPreferences.getInstance();
    collection = jsonDecode(preferences.getString('collection') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList();
    notifyListeners();
  }

  Future<bool> initialConfigLoaded() async {
    var preferences = await SharedPreferences.getInstance();
    return preferences.getBool('initialConfigLoaded') ?? false;
  }

  addCoin(Coin coin) {
    collection.add(coin);
    notifyListeners();
  }

  exportCollection() {
    var jsonString = jsonEncode(collection);
  }

  importCollection(String jsonString) async {
    final jsonList = jsonDecode(jsonString);
    final directory = await getApplicationDocumentsDirectory();
  }
}
