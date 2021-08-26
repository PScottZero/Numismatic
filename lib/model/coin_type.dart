import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coin_type.g.dart';

@JsonSerializable()
class CoinType {
  String name;
  String? greysheetName;
  String photogradeName;

  CoinType({
    required this.name,
    this.greysheetName,
    required this.photogradeName,
  });

  String getGreysheetName() {
    if (this.greysheetName == null) {
      return "${name}s";
    } else {
      return this.greysheetName!;
    }
  }

  static CoinType? coinTypeFromString(String type, List<CoinType> coinTypes) {
    try {
      return coinTypes
          .where((element) =>
              element.name == type ||
              element.getGreysheetName() == type ||
              element.photogradeName == type)
          .first;
    } catch (_) {
      return null;
    }
  }

  static Future<CoinType?> coinTypeFromStringAsync(String type) async {
    return coinTypeFromString(type, await coinTypesFromJson);
  }

  static Future<List<CoinType>> get coinTypesFromJson async => (jsonDecode(
        await rootBundle.loadString('assets/json/coin-types.json'),
      ) as List<dynamic>)
          .map((type) => CoinType.fromJson(type))
          .toList();

  factory CoinType.fromJson(Map<String, dynamic> json) =>
      _$CoinTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTypeToJson(this);
}
