import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coin_type.g.dart';

@JsonSerializable()
class CoinType {
  String name;
  String? greysheetName;
  String? photogradeName;
  double? denomination;

  static List<CoinType> coinTypes = [];

  CoinType({
    required this.name,
    this.greysheetName,
    required this.photogradeName,
    required this.denomination,
  });

  String getGreysheetName() {
    if (this.greysheetName == null) {
      return "${name}s";
    } else {
      return this.greysheetName!;
    }
  }

  String getPhotogradeName() {
    if (this.photogradeName == null) {
      return name.replaceAll(' ', '');
    } else {
      return this.photogradeName!;
    }
  }

  static CoinType? coinTypeFromString(String type) {
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

  static Future<List<CoinType>> get coinTypesFromJson async => (jsonDecode(
        await rootBundle.loadString('assets/json/coin-types.json'),
      ) as List<dynamic>)
          .map((type) => CoinType.fromJson(type))
          .toList();

  factory CoinType.fromJson(Map<String, dynamic> json) =>
      _$CoinTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTypeToJson(this);
}
