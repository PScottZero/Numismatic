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
  String? variation;
  MultiSourceValue? retailPrice;
  MultiSourceValue? mintage;
  DateTime? retailPriceLastUpdated;

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
    this.variation,
    this.retailPrice,
    this.mintage,
    this.retailPriceLastUpdated,
  ]);

  void setProperty(String property, String value) {
    switch (property) {
      case 'Year':
        year = value;
        break;
      case 'Mint Mark':
        mintMark = value;
        break;
      case 'Variation':
        variation = value;
        break;
      case 'Grade':
        grade = value;
        break;
      default:
        break;
    }
  }

  String get fullType {
    return '${year ?? ""}${mintMark != null ? "-$mintMark" : ""} $type ${variation ?? ""}'
        .trim();
  }

  String? get fullDenomintation {
    if (currencySymbol == CurrencySymbol.CENT) {
      return '$denomination${currencySymbol?.symbol}';
    } else if (currencySymbol != null) {
      return '${currencySymbol?.symbol}$denomination';
    } else {
      return null;
    }
  }

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
