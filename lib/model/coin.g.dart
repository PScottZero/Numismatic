// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
      StringReference.fromJson(json['type'] as Map<String, dynamic>),
      json['year'] as String?,
      json['mintMark'] as String?,
      StringReference.fromJson(json['variation'] as Map<String, dynamic>),
      json['mintage'] as String?,
      StringReference.fromJson(json['grade'] as Map<String, dynamic>),
      json['retailPrice'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['notes'] as String?,
      json['inCollection'] as bool,
      _$enumDecode(_$DataSourceEnumMap, json['imagesSource']),
      _$enumDecode(_$DataSourceEnumMap, json['mintageSource']),
      _$enumDecode(_$DataSourceEnumMap, json['retailPriceSource']),
      json['photogradeName'] as String?,
      json['photogradeGrade'] as String?,
      json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      json['retailPriceLastUpdated'] == null
          ? null
          : DateTime.parse(json['retailPriceLastUpdated'] as String),
    );

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'type': instance.type,
      'year': instance.year,
      'mintMark': instance.mintMark,
      'variation': instance.variation,
      'mintage': instance.mintage,
      'grade': instance.grade,
      'retailPrice': instance.retailPrice,
      'images': instance.images,
      'notes': instance.notes,
      'inCollection': instance.inCollection,
      'imagesSource': _$DataSourceEnumMap[instance.imagesSource],
      'mintageSource': _$DataSourceEnumMap[instance.mintageSource],
      'retailPriceSource': _$DataSourceEnumMap[instance.retailPriceSource],
      'photogradeName': instance.photogradeName,
      'photogradeGrade': instance.photogradeGrade,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'retailPriceLastUpdated':
          instance.retailPriceLastUpdated?.toIso8601String(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DataSourceEnumMap = {
  DataSource.auto: 'auto',
  DataSource.manual: 'manual',
  DataSource.none: 'none',
};
