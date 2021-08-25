import 'package:json_annotation/json_annotation.dart';
part 'greysheet_price_request.g.dart';

@JsonSerializable()
class GreysheetPriceRequest {
  String type;
  String variant;
  String grade;

  GreysheetPriceRequest(this.type, this.variant, this.grade);

  factory GreysheetPriceRequest.fromJson(Map<String, dynamic> json) =>
      _$GreysheetPriceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GreysheetPriceRequestToJson(this);
}
