// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pcgs_photograde_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PCGSPhotogradeRequest _$PCGSPhotogradeRequestFromJson(
    Map<String, dynamic> json) {
  return PCGSPhotogradeRequest(
    json['type'] as String,
    json['grade'] as String,
  );
}

Map<String, dynamic> _$PCGSPhotogradeRequestToJson(
        PCGSPhotogradeRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'grade': instance.grade,
    };
