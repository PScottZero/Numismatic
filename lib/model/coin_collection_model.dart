import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:numismatic/scraper/greysheet_scraper.dart';
import 'package:permission_handler/permission_handler.dart';
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

  overwriteCoin(int index, Coin coin) async {
    allCoins[index] = coin;
    saveCoins();
  }

  addCoin(Coin coin) {
    allCoins.add(coin);
    saveCoins();
    notifyListeners();
  }

  deleteCoin(int index) {
    allCoins.removeAt(index);
    saveCoins();
    notifyListeners();
  }

  Coin? coinAtIndex(int index) {
    if (index >= 0 && index < allCoins.length) {
      return allCoins[index];
    }
    return null;
  }

  toggleInCollection(Coin coin) {
    coin.inCollection = !coin.inCollection;
    saveCoins();
    notifyListeners();
  }

  saveCollectionJson() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (await Permission.storage.request().isGranted && dir != null) {
      await File('${dir.path}/collection.json').writeAsString(
        jsonEncode(allCoins.map((e) => e.toJson()).toList()),
      );
    }
  }

  Future<bool> loadCollectionJson() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (await Permission.storage.request().isGranted && dir != null) {
      var file = File('${dir.path}/collection.json');
      if (await file.exists()) {
        allCoins = jsonDecode(
          await file.readAsString(),
        ).map<Coin>((e) => Coin.fromJson(e)).toList() as List<Coin>;
        saveCoins();
        notifyListeners();
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  notify(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: ViewConstants.fontSmall,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  refresh() => notifyListeners();
}
