// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin(
    type: json['type'] as String,
    year: json['year'] as String?,
    mintMark: json['mintMark'] as String?,
    variation: json['variation'] as String?,
    mintage: json['mintage'] as String?,
    grade: json['grade'] as String?,
    retailPrice: json['retailPrice'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    notes: json['notes'] as String?,
    inCollection: json['inCollection'] as bool,
    imagesSource: _$enumDecode(_$DataSourceEnumMap, json['imagesSource']),
    mintageSource: _$enumDecode(_$DataSourceEnumMap, json['mintageSource']),
    retailPriceSource:
        _$enumDecode(_$DataSourceEnumMap, json['retailPriceSource']),
    photogradeName: json['photogradeName'] as String?,
    photogradeGrade: json['photogradeGrade'] as String?,
    dateAdded: json['dateAdded'] == null
        ? null
        : DateTime.parse(json['dateAdded'] as String),
    retailPriceLastUpdated: json['retailPriceLastUpdated'] == null
        ? null
        : DateTime.parse(json['retailPriceLastUpdated'] as String),
  );
}

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
