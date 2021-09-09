// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greysheet_price_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GreysheetPriceRequest _$GreysheetPriceRequestFromJson(
        Map<String, dynamic> json) =>
    GreysheetPriceRequest(
      json['type'] as String,
      json['variant'] as String,
      json['grade'] as String,
    );

Map<String, dynamic> _$GreysheetPriceRequestToJson(
        GreysheetPriceRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'variant': instance.variant,
      'grade': instance.grade,
    };
