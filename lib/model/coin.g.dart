// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin(
    type: json['type'] as String,
    year: json['year'] as String?,
    variation: json['variation'] as String?,
    mintMark: json['mintMark'] as String?,
    grade: json['grade'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    notes: json['notes'] as String?,
    mintage: json['mintage'] as String?,
    retailPrice: json['retailPrice'] as String?,
    retailPriceRequest: json['retailPriceRequest'] == null
        ? null
        : GreysheetPriceRequest.fromJson(
            json['retailPriceRequest'] as Map<String, dynamic>),
    photogradeName: json['photogradeName'] as String?,
    retailPriceLastUpdated: json['retailPriceLastUpdated'] == null
        ? null
        : DateTime.parse(json['retailPriceLastUpdated'] as String),
  );
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'type': instance.type,
      'year': instance.year,
      'variation': instance.variation,
      'mintMark': instance.mintMark,
      'grade': instance.grade,
      'images': instance.images,
      'notes': instance.notes,
      'mintage': instance.mintage,
      'retailPrice': instance.retailPrice,
      'retailPriceRequest': instance.retailPriceRequest,
      'photogradeName': instance.photogradeName,
      'retailPriceLastUpdated':
          instance.retailPriceLastUpdated?.toIso8601String(),
    };
