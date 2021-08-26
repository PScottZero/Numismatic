import 'package:json_annotation/json_annotation.dart';
import 'package:numismatic/model/greysheet_price_request.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  String type;
  String? year;
  String? variation;
  String? mintMark;
  String? grade;
  List<String>? images;
  String? notes;
  String? mintage;
  String? retailPrice;
  GreysheetPriceRequest? retailPriceRequest;
  String? photogradeName;
  String? photogradeGrade;
  DateTime? retailPriceLastUpdated;
  bool inCollection;

  Coin({
    this.type = '',
    this.year,
    this.variation,
    this.mintMark,
    this.grade,
    this.images,
    this.notes,
    this.mintage,
    this.retailPrice,
    this.retailPriceRequest,
    this.photogradeName,
    this.retailPriceLastUpdated,
    this.inCollection = true,
  });

  String get fullType {
    final yearAndMintMark = yearAndMintMarkFromVariation(variation ?? '');
    final remove = yearAndMintMark[1] != null
        ? yearAndMintMark.join('-')
        : yearAndMintMark[0] != null
            ? yearAndMintMark[0]
            : '';
    print(remove);
    return '${year ?? ""}${mintMark != null ? "-$mintMark" : ""} $type ${variation != null ? '(${variation!.replaceAll(remove!, '')})' : ''}'
        .trim();
  }

  List<String?> yearAndMintMarkFromVariation(String variation) {
    String? year;
    String? mintMark;
    if (variation.length > 0) {
      try {
        year = variation.split(' ')[0];
        if (year.contains('-')) {
          var split = year.split('-');
          year = split[0];
          mintMark = split[1];
        }
      } catch (_) {}
    }
    return [year, mintMark];
  }

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
