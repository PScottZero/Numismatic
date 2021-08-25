import 'package:json_annotation/json_annotation.dart';
part 'greysheet_static_data.g.dart';

@JsonSerializable()
class GreysheetStaticData {
  @JsonKey(name: 'url')
  String pricesUrl;
  String? mintage;

  GreysheetStaticData(this.pricesUrl, {this.mintage});

  factory GreysheetStaticData.fromJson(Map<String, dynamic> json) =>
      _$GreysheetStaticDataFromJson(json);

  Map<String, dynamic> toJson() => _$GreysheetStaticDataToJson(this);
}
