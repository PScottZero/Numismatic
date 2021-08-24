// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi-source-value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSourceValue _$MultiSourceValueFromJson(Map<String, dynamic> json) {
  return MultiSourceValue(
    manualSource: json['manualSource'] as String?,
    urlSource: json['urlSource'] as String?,
  );
}

Map<String, dynamic> _$MultiSourceValueToJson(MultiSourceValue instance) =>
    <String, dynamic>{
      'manualSource': instance.manualSource,
      'urlSource': instance.urlSource,
    };
