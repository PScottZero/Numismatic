// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mintage-request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MintageRequest _$MintageRequestFromJson(Map<String, dynamic> json) {
  return MintageRequest(
    json['type'] as String,
    json['year'] as String,
    mintMark: json['mintMark'] as String?,
    details: json['details'] as String?,
  );
}

Map<String, dynamic> _$MintageRequestToJson(MintageRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'year': instance.year,
      'mintMark': instance.mintMark,
      'details': instance.details,
    };
