import 'package:numismatic/model/currency_symbol.dart';

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
  double? value; // null: no value, -1: PCGS provided value
  double? mintage; // null: no mintage, -1: PCGS provided mintage

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
    this.value,
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
        value = json['value'];

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
        'value': value
      };
}
