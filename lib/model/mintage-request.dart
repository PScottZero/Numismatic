import 'package:json_annotation/json_annotation.dart';
import 'coin.dart';
part 'mintage-request.g.dart';

@JsonSerializable()
class MintageRequest {
  String type;
  String year;
  String? mintMark;
  String? details;

  MintageRequest(this.type, this.year, {this.mintMark, this.details});

  static MintageRequest fromCoin(Coin coin) {
    return MintageRequest(coin.type, coin.year ?? "", mintMark: coin.mintMark);
  }

  factory MintageRequest.fromJson(Map<String, dynamic> json) =>
      _$MintageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MintageRequestToJson(this);
}
