// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinType _$CoinTypeFromJson(Map<String, dynamic> json) => CoinType(
      name: json['name'] as String,
      greysheetName: json['greysheetName'] as String?,
      photogradeName: json['photogradeName'] as String?,
      denomination: (json['denomination'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoinTypeToJson(CoinType instance) => <String, dynamic>{
      'name': instance.name,
      'greysheetName': instance.greysheetName,
      'photogradeName': instance.photogradeName,
      'denomination': instance.denomination,
    };
