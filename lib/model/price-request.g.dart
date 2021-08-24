// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price-request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceRequest _$PriceRequestFromJson(Map<String, dynamic> json) {
  return PriceRequest(
    json['type'] as String,
    json['year'] as String,
    mintMark: json['mintMark'] as String?,
    details: json['details'] as String?,
    grade: json['grade'] as String?,
  );
}

Map<String, dynamic> _$PriceRequestToJson(PriceRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'year': instance.year,
      'mintMark': instance.mintMark,
      'details': instance.details,
      'grade': instance.grade,
    };
