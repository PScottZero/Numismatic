import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numismatic/model/greysheet_static_data.dart';
import 'package:numismatic/model/reference.dart';
import 'package:numismatic/model/sort_method.dart';
import 'package:numismatic/services/greysheet_scraper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/coin_comparator.dart';
import 'coin.dart';
import 'coin_type.dart';

class CoinCollectionModel extends ChangeNotifier with WidgetsBindingObserver {
  List<Coin> coins = [];
  List<Coin> get collection =>
      coins.where((element) => element.inCollection).toList();
  List<Coin> get wantlist =>
      coins.where((element) => !element.inCollection).toList();
  Map<String, Map<String, GreysheetStaticData>>? greysheetStaticData;
  StringReference searchString = StringReference();
  bool isLoading = true;
  int imageIndex = 0;
  BuildContext snackBarContext;

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  CoinCollectionModel(this.snackBarContext) {
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
    final appDirectory = (await getApplicationDocumentsDirectory()).path;
    final coinsDirectory = Directory('$appDirectory/coins/');
    if (coinsDirectory.existsSync()) {
      var coinFiles = coinsDirectory.listSync();
      if (coinFiles.isNotEmpty) {
        for (var coinFile in coinFiles) {
          final coin = File(coinFile.path);
          coins.add(Coin.fromJson(jsonDecode(coin.readAsStringSync())));
        }
      }
    } else {
      coinsDirectory.createSync();
    }
    isLoading = false;
    _sortCoins();
    notifyListeners();
  }

  saveCoin(Coin coin) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final file = File('$directory/coins/${coin.id}.json');
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync(jsonEncode(coin));
  }

  deleteCoinById(String id) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final file = File('$directory/coins/$id.json');
    file.deleteSync();
  }

  overwriteCoin(Coin destination, Coin source) {
    Coin.set(destination, source);
    saveCoin(destination);
    _sortCoins();
    notifyListeners();
  }

  addCoin(Coin coin, [bool notify = true]) async {
    coins.add(coin);
    _sortCoins();
    await saveCoin(coin);
    if (notify) {
      notifyListeners();
    }
  }

  deleteCoin(Coin coin, [bool notify = true]) async {
    coins.remove(coin);
    await deleteCoinById(coin.id);
    if (notify) {
      notifyListeners();
    }
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

  Future<String> backupCoins() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final directory =
          Directory('/storage/emulated/0/Documents/NumismaticBU/');
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }
      directory.createSync();
      for (var coin in coins) {
        final file =
            File('/storage/emulated/0/Documents/NumismaticBU/${coin.id}.json');
        file.createSync();
        file.writeAsStringSync(jsonEncode(coin));
      }
      return 'Successfully backed up coins';
    }
    return 'Permissions error';
  }

  Future<String> restoreCoins() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      final backupDirectory =
          Directory('/storage/emulated/0/Documents/NumismaticBU/');
      if (!backupDirectory.existsSync()) {
        return 'No backup found';
      }
      while (coins.isNotEmpty) {
        await deleteCoin(coins[0]);
      }
      var coinFiles = backupDirectory.listSync();
      if (coinFiles.isNotEmpty) {
        for (var coinFile in coinFiles) {
          final coin = File(coinFile.path);
          await addCoin(
            Coin.fromJson(jsonDecode(coin.readAsStringSync())),
            false,
          );
        }
      }
      notifyListeners();
      return 'Successfully restored coins';
    }
    return 'Permissions error';
  }

  _sortCoins() => coins.sort(CoinComparator.comparator);

  refresh() => notifyListeners();
}
