import 'package:numismatic/model/currency_symbol.dart';

import 'multiple-source-property.dart';

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
  MultiSourceValue<double>? retailPrice;
  MultiSourceValue<double>? mintage;

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

  Coin.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        year = json['year'],
        mintMark = json['mintMark'],
        grade = json['grade'],
        images =
            List.from(json['images'] ?? '[]').map((e) => e as String).toList(),
        notes = json['notes'],
        denomination = json['denomination'],
        currencySymbol = fromString(json['currencySymbol'] ?? ''),
        composition = json['composition'],
        retailPrice = json['value'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'year': year,
        'mintMark': mintMark,
        'grade': grade,
        'images': images,
        'notes': notes,
        'denomination': denomination,
        'currencySymbol': currencySymbol,
        'composition': composition,
        'value': retailPrice
      };
}
