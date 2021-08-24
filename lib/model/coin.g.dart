// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin(
    json['type'] as String,
    json['year'] as String?,
    json['mintMark'] as String?,
    json['grade'] as String?,
    (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    json['notes'] as String?,
    json['denomination'] as int?,
    _$enumDecodeNullable(_$CurrencySymbolEnumMap, json['currencySymbol']),
    json['composition'] as String?,
    json['retailPrice'] == null
        ? null
        : MultiSourceValue.fromJson(
            json['retailPrice'] as Map<String, dynamic>),
    json['mintage'] == null
        ? null
        : MultiSourceValue.fromJson(json['mintage'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'type': instance.type,
      'year': instance.year,
      'mintMark': instance.mintMark,
      'grade': instance.grade,
      'images': instance.images,
      'notes': instance.notes,
      'denomination': instance.denomination,
      'currencySymbol': _$CurrencySymbolEnumMap[instance.currencySymbol],
      'composition': instance.composition,
      'retailPrice': instance.retailPrice,
      'mintage': instance.mintage,
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

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$CurrencySymbolEnumMap = {
  CurrencySymbol.CENT: 'CENT',
  CurrencySymbol.DOLLAR: 'DOLLAR',
  CurrencySymbol.UNKNOWN: 'UNKNOWN',
};
