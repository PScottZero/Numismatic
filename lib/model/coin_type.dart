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

  String getGreysheetName([bool isProof = false]) {
    if (greysheetName == null) {
      return "${name}s${isProof ? ' (Proof)' : ''}";
    } else {
      return '$greysheetName${isProof ? ' (Proof)' : ''}';
    }
  }

  String getPhotogradeName() {
    if (photogradeName == null) {
      return name.replaceAll(' ', '');
    } else {
      return photogradeName!;
    }
  }

  static CoinType? coinTypeFromString(String type) {
    try {
      return coinTypes
          .where((element) =>
              element.name == type ||
              element.getGreysheetName() == type ||
              element.getGreysheetName() == type.replaceAll(' (Proof)', '') ||
              element.photogradeName == type)
          .first;
    } catch (_) {
      return null;
    }
  }

  static List<String> get allCoinTypes {
    var types = coinTypes.map((e) => e.name).toList();
    types.sort();
    return types;
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
