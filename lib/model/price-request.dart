import 'package:json_annotation/json_annotation.dart';
import 'coin.dart';
part 'price-request.g.dart';

@JsonSerializable()
class PriceRequest {
  String type;
  String year;
  String? mintMark;
  String? details;
  String? grade;

  PriceRequest(this.type, this.year, {this.mintMark, this.details, this.grade});

  static PriceRequest fromCoin(Coin coin) {
    return PriceRequest(
      coin.type,
      coin.year ?? "",
      mintMark: coin.mintMark,
      grade: coin.grade,
    );
  }

  factory PriceRequest.fromJson(Map<String, dynamic> json) =>
      _$PriceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRequestToJson(this);
}
