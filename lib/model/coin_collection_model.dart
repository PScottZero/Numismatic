import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin_type.dart';
import 'coin.dart';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> collection = [];
  List<Coin> wantlist = [];
  List<CoinType> coinTypes = [];
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;

  CoinCollectionModel() {
    loadTypes();
    loadGreysheetStaticData();
    loadCollection();
    loadWantlist();
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
        .toList() as List<Coin>;
    notifyListeners();
  }

  loadWantlist() async {
    var preferences = await SharedPreferences.getInstance();
    wantlist = jsonDecode(preferences.getString('wantlist') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList();
    notifyListeners();
  }

  saveCollection() async {
    collection.sort((a, b) => a.fullType.compareTo(b.fullType));
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'collection',
      jsonEncode(collection.map((e) => e.toJson()).toList()),
    );
  }

  saveWantlist() async {
    wantlist.sort((a, b) => a.fullType.compareTo(b.fullType));
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'wantlist',
      jsonEncode(collection.map((e) => e.toJson()).toList()),
    );
  }

  addCoin(Coin coin) {
    if (coin.inCollection) {
      collection.add(coin);
      saveCollection();
    } else {
      wantlist.add(coin);
      saveWantlist();
    }
    notifyListeners();
  }

  deleteCoin(Coin coin) {
    if (coin.inCollection) {
      collection.remove(coin);
      saveCollection();
    } else {
      wantlist.remove(coin);
      saveWantlist();
    }
    notifyListeners();
  }

  moveCoinToCollection(Coin coin) {
    coin.inCollection = true;
    collection.add(coin);
    wantlist.remove(coin);
    saveCollection();
    saveWantlist();
    notifyListeners();
  }

  moveCoinToWantlist(Coin coin) {
    coin.inCollection = false;
    collection.remove(coin);
    wantlist.add(coin);
    saveCollection();
    saveWantlist();
    notifyListeners();
  }

  refresh() => notifyListeners();
}
