// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinType _$CoinTypeFromJson(Map<String, dynamic> json) {
  return CoinType(
    name: json['name'] as String,
    greysheetName: json['greysheetName'] as String?,
    photogradeName: json['photogradeName'] as String,
  );
}

Map<String, dynamic> _$CoinTypeToJson(CoinType instance) => <String, dynamic>{
      'name': instance.name,
      'greysheetName': instance.greysheetName,
      'photogradeName': instance.photogradeName,
    };
