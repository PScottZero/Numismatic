import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:numislog/model/coin.dart';
import 'package:numislog/model/app_model.dart';
import 'package:numislog/model/coin_type.dart';
import 'package:numislog/model/data_source.dart';

import 'greysheet_scraper.dart';

class CoinDataRetriever {
  static setMintage(Coin coin, AppModel? model) async {
    await _handleDataSource(
      coin.mintageSource,
      () async => coin.mintage = model
          ?.greysheetStaticData![CoinType.coinTypeFromString(coin.type.value)
                  ?.getGreysheetName(coin.isProof) ??
              coin.type.value]?[coin.variation.value]
          ?.mintage,
      () => coin.mintage = null,
    );
  }

  static setRetailPrice(Coin coin, AppModel? model) async {
    await _handleDataSource(
      coin.retailPriceSource,
      () async {
        if (coin.grade.valueNullable != null) {
          coin.retailPrice = await GreysheetScraper.retailPriceForCoin(coin);
          coin.retailPriceLastUpdated = DateTime.now();
        }
      },
      () => coin.retailPrice = null,
    );
  }

  static setImages(Coin coin, AppModel? model) async {
    await _handleDataSource(
      coin.imagesSource,
      () async => coin.images = await _getImagesFromPCGS(coin),
      () => coin.images = null,
    );
  }

  static _handleDataSource(
    DataSource? source,
    AsyncCallback onAuto,
    VoidCallback onNull,
  ) async {
    if (source == DataSource.auto) {
      return await onAuto();
    } else if (source == DataSource.none) {
      return onNull();
    }
  }

  static Future<List<String>?> _getImagesFromPCGS(Coin coin) async {
    var photogradeName =
        CoinType.coinTypeFromString(coin.type.value)?.getPhotogradeName();
    if (photogradeName == null) {
      return null;
    }
    var pcgsGrade =
        coin.photogradeGrade ?? _gradeToNumber(coin.grade.value) ?? 64;
    var urls = [
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeName-${pcgsGrade}o.jpg',
      'https://i.pcgs.com/s3/cu-pcgs/Photograde/500/$photogradeName-${pcgsGrade}r.jpg',
    ];
    List<String> images = [];
    for (var url in urls) {
      var response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5))
          .onError((error, stackTrace) => http.Response('Error', 500));
      if (response.statusCode == 200) {
        images.add(base64Encode(response.bodyBytes));
      }
    }
    return images;
  }

  static String? _gradeToNumber(String grade) {
    var gradeSplit = grade.split('-');
    if (gradeSplit.length > 1) {
      var grade = int.tryParse(gradeSplit[1]);
      return grade?.toString().padLeft(2, '0');
    }
    return null;
  }
}
