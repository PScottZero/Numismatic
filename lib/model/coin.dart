import 'package:numismatic/model/currency_symbol.dart';
import 'package:json_annotation/json_annotation.dart';

import 'multi-source-value.dart';
part 'coin.g.dart';

@JsonSerializable()
class Coin {
  String type;
  String? year;
  String? mintMark;
  String? grade;
  List<String>? images;
  String? notes;
  int? denomination;
  CurrencySymbol? currencySymbol;
  String? composition;
  MultiSourceValue? retailPrice;
  MultiSourceValue? mintage;

  Coin(
    this.type, [
    this.year,
    this.mintMark,
    this.grade,
    this.images,
    this.notes,
    this.denomination,
    this.currencySymbol,
    this.composition,
    this.retailPrice,
    this.mintage,
  ]);

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
