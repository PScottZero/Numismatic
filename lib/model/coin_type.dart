import 'package:json_annotation/json_annotation.dart';
part 'coin_type.g.dart';

@JsonSerializable()
class CoinType {
  String name;
  String? greysheetName;
  String photogradeName;

  CoinType({
    required this.name,
    this.greysheetName,
    required this.photogradeName,
  });

  String getGreysheetName() {
    if (this.greysheetName == null) {
      return "${name}s";
    } else {
      return this.greysheetName!;
    }
  }

  factory CoinType.fromJson(Map<String, dynamic> json) =>
      _$CoinTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CoinTypeToJson(this);
}
