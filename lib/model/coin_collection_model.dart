import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:numismatic/model/reference.dart';
import 'package:numismatic/model/sort_method.dart';
import 'package:numismatic/scraper/greysheet_scraper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin.dart';
import 'coin_comparator.dart';
import 'coin_type.dart';

const String ALL_COINS_KEY = 'coins';

class CoinCollectionModel extends ChangeNotifier with WidgetsBindingObserver {
  List<Coin> allCoins = [];
  List<Coin> get collection =>
      allCoins.where((element) => element.inCollection).toList();
  List<Coin> get wantlist =>
      allCoins.where((element) => !element.inCollection).toList();
  List<CoinType> coinTypes = [];
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;
  StringReference searchString = StringReference('');

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  CoinCollectionModel() {
    WidgetsBinding.instance?.addObserver(this);
    CoinComparator.setSortMethod(SortMethod.type);
    loadTypes();
    loadGreysheetStaticData();
    loadCoins();
  }

  List<String> get allCoinTypes {
    var types = greysheetStaticData?.keys
            .map((e) => CoinType.coinTypeFromString(e)?.name ?? e)
            .toList() ??
        [];
    types.sort();
    return types;
  }

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
    GreysheetScraper.staticData = greysheetStaticData;
    notifyListeners();
  }

  loadCoins() async {
    var preferences = await SharedPreferences.getInstance();
    allCoins = jsonDecode(preferences.getString('coins') ?? '[]')
        .map<Coin>((e) => Coin.fromJson(e))
        .toList() as List<Coin>;
    allCoins.sort(CoinComparator.comparator);
    notifyListeners();
  }

  saveCoins() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(
      'coins',
      jsonEncode(allCoins.map((e) => e.toJson()).toList()),
    );
  }

  overwriteCoin(Coin destination, Coin source) {
    Coin.set(destination, source);
    _sortCoins();
    saveCoins();
    notifyListeners();
  }

  addCoin(Coin coin) {
    allCoins.add(coin);
    _sortCoins();
    saveCoins();
    notifyListeners();
  }

  deleteCoin(Coin coin) {
    allCoins.remove(coin);
    _sortCoins();
    saveCoins();
    notifyListeners();
  }

  toggleInCollection(Coin coin) {
    coin.inCollection = !coin.inCollection;
    saveCoins();
    notifyListeners();
  }

  setSortMethod(SortMethod method) {
    CoinComparator.setSortMethod(method);
    _sortCoins();
    notifyListeners();
  }

  toggleSortDirection() {
    CoinComparator.ascending = !CoinComparator.ascending;
    _sortCoins();
    notifyListeners();
  }

  _sortCoins() => allCoins.sort(CoinComparator.comparator);

  refresh() => notifyListeners();
}
