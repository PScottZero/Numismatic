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
  double? mintage;
  double? retailPrice;
  GreysheetPriceRequest? retailPriceRequest;
  DateTime? retailPriceLastUpdated;

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
    this.retailPriceLastUpdated,
  });

  void setProperty(String property, String? value) {
    if (value == '') value = null;
    switch (property) {
      case 'Type':
        type = value!;
        break;
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

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
