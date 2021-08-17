import 'package:numismatic/model/currency_symbol.dart';

class Coin {
  String type;
  String? date;
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
    this.date,
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
        date = json['date'],
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
        'date': date,
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
