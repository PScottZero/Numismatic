import 'package:numismatic/model/currency_symbol.dart';

class Coin {
  String type;
  String? year;
  String? mintMark;
  String? grade;
  List<String>? images;
  String? reverse;
  String? notes;
  int? minValue;
  int? maxValue;
  int? denomination;
  CurrencySymbol? currencySymbol;
  String? composition;

  Coin(
    this.type, [
    this.year,
    this.mintMark,
    this.grade,
    this.images,
    this.notes,
    this.minValue,
    this.maxValue,
    this.denomination,
    this.currencySymbol,
    this.composition,
  ]);

  Coin.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        year = json['year'],
        mintMark = json['mintMark'],
        grade = json['grade'],
        images =
            List.from(json['images'] ?? '[]').map((e) => e as String).toList(),
        notes = json['notes'],
        minValue = json['minValue'],
        maxValue = json['maxValue'],
        denomination = json['denomination'],
        currencySymbol = json['currencySign'],
        composition = json['composition'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'year': year,
        'mintMark': mintMark,
        'grade': grade,
        'images': images,
        'reverse': reverse,
        'notes': notes,
        'minValue': minValue,
        'maxValue': maxValue,
        'denomination': denomination,
        'currencySign': currencySymbol,
        'composition': composition
      };
}
