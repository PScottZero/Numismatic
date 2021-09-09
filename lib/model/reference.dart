import 'package:json_annotation/json_annotation.dart';

part 'reference.g.dart';

@JsonSerializable()
class StringReference {
  String value;
  String? get valueNullable => value != '' ? value : null;

  StringReference([this.value = '']);

  factory StringReference.fromJson(Map<String, dynamic> json) =>
      _$StringReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$StringReferenceToJson(this);
}
