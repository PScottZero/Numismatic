import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:numismatic/scraper/greysheet-scraper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

import 'coin_type.dart';
import 'coin.dart';

const String ALL_COINS_KEY = 'coins';

class CoinCollectionModel extends ChangeNotifier {
  List<Coin> allCoins = [];
  List<Coin> get collection =>
      allCoins.where((element) => element.inCollection).toList();
  List<Coin> get wantlist =>
      allCoins.where((element) => !element.inCollection).toList();
  List<CoinType> coinTypes = [];
  List<Tuple2<String, String>> gradeOptions = [];
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;

  CoinCollectionModel() {
    loadTypes();
    loadGreysheetStaticData();
    loadCoins();
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

  toggleInCollectino(Coin coin) {
    coin.inCollection = !coin.inCollection;
    saveCoins();
    notifyListeners();
  }

  setGradeOptionsAndPrices(List<Tuple2<String, String>> options) {
    gradeOptions = options;
    notifyListeners();
  }

  getGreysheetGradesForCoin(Coin coin) async {
    gradeOptions = await GreysheetScraper.retailPriceForCoin(
            coin, greysheetStaticData ?? Map(), coinTypes) ??
        [];
    notifyListeners();
  }

  setCoinPrice(Coin coin, String grade) {
    try {
      coin.retailPrice = gradeOptions
          .where(
            (element) => element.item1 == grade,
          )
          .first
          .item2;
      notifyListeners();
    } catch (ex) {}
  }

  static String gradeToNumber(String grade) {
    var gradeSplit = grade.split(' ');
    var gradePart = grade;
    if (gradeSplit.length > 1) gradePart = gradeSplit[0];
    switch (gradePart.length) {
      case 4:
        return gradePart.substring(2, 4);
      case 3:
        if (gradePart[0] == 'F') {
          return gradePart.substring(1, 3);
        }
        return gradePart[2];
      case 2:
        return gradePart[1];
      default:
        return '';
    }
  }

  refresh() => notifyListeners();
}
