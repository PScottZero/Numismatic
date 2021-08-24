import 'package:json_annotation/json_annotation.dart';
import 'coin.dart';
part 'pcgs-photograde-request.g.dart';

@JsonSerializable()
class PCGSPhotogradeRequest {
  String type;
  String grade;

  PCGSPhotogradeRequest(this.type, this.grade);

  static PCGSPhotogradeRequest fromCoin(Coin coin) {
    return PCGSPhotogradeRequest(coin.type, coin.grade ?? "");
  }

  factory PCGSPhotogradeRequest.fromJson(Map<String, dynamic> json) =>
      _$PCGSPhotogradeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PCGSPhotogradeRequestToJson(this);
}
