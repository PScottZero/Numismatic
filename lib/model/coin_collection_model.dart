import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/constants/view_constants.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:numismatic/model/reference.dart';
import 'package:numismatic/model/sort_method.dart';
import 'package:numismatic/scraper/greysheet_scraper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coin.dart';
import 'coin_comparator.dart';
import 'coin_type.dart';

const String coinKeysKey = 'coinKeys';

class CoinCollectionModel extends ChangeNotifier with WidgetsBindingObserver {
  List<String> _coinKeys = [];
  List<Coin> coins = [];
  List<Coin> get collection =>
      coins.where((element) => element.inCollection).toList();
  List<Coin> get wantlist =>
      coins.where((element) => !element.inCollection).toList();
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;
  StringReference searchString = StringReference();
  int imageIndex = 0;

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  CoinCollectionModel() {
    WidgetsBinding.instance?.addObserver(this);
    CoinComparator.setSortMethod(SortMethod.denomination);
    loadTypes();
    loadGreysheetStaticData();
    loadCoins();
  }

  loadTypes() async {
    CoinType.coinTypes = await CoinType.coinTypesFromJson;
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
    _coinKeys = preferences.getStringList(coinKeysKey) ?? [];
    for (var key in _coinKeys) {
      var json = preferences.getString(key);
      if (json != null) {
        coins.add(Coin.fromJson(jsonDecode(json)));
      }
    }
    _sortCoins();
    notifyListeners();
  }

  saveCoinKeys() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList(coinKeysKey, _coinKeys);
  }

  saveCoin(Coin coin) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(coin.id, jsonEncode(coin));
  }

  deleteCoinById(String id) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.remove(id);
  }

  overwriteCoin(Coin destination, Coin source) {
    Coin.set(destination, source);
    saveCoin(destination);
    _sortCoins();
    notifyListeners();
  }

  addCoin(Coin coin) {
    coins.add(coin);
    _coinKeys.add(coin.id);
    _sortCoins();
    saveCoin(coin);
    saveCoinKeys();
    notifyListeners();
  }

  deleteCoin(Coin coin) {
    coins.remove(coin);
    _coinKeys.remove(coin.id);
    deleteCoinById(coin.id);
    saveCoinKeys();
    notifyListeners();
  }

  toggleInCollection(Coin coin) {
    coin.inCollection = !coin.inCollection;
    saveCoin(coin);
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

  backupCoins(BuildContext context) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final file =
          File('/storage/emulated/0/Documents/NumismaticBU/manifest.json');
      if (!file.existsSync()) {
        file.create(recursive: true);
      }
      file.writeAsString(jsonEncode(_coinKeys));
      for (var coin in coins) {
        final file = File(
            '/storage/emulated/0/Documents/NumismaticBU/coins/${coin.id}.json');
        if (!file.existsSync()) {
          file.create(recursive: true);
        }
        file.writeAsString(jsonEncode(coin));
      }
      _notify('Successfully backed up coins', context);
    }
  }

  restoreCoins(BuildContext context) async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final file =
          File('/storage/emulated/0/Documents/NumismaticBU/manifest.json');
      if (!file.existsSync()) {
        _notify('No backup found', context);
        return;
      }
      final coinKeys = List<String>.from(jsonDecode(file.readAsStringSync()));
      coins = [];
      for (var key in coinKeys) {
        final file =
            File('/storage/emulated/0/Documents/NumismaticBU/coins/$key.json');
        if (!file.existsSync()) {
          file.create(recursive: true);
        }
        addCoin(Coin.fromJson(jsonDecode(file.readAsStringSync())));
      }
      _notify('Successfully restored coins', context);
      notifyListeners();
    }
  }

  _notify(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: ViewConstants.fontSmall,
          ),
        ),
      ),
    );
  }

  _sortCoins() => coins.sort(CoinComparator.comparator);

  refresh() => notifyListeners();
}
