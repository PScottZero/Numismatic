import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
part 'multi-source-value.g.dart';

@JsonSerializable()
class MultiSourceValue {
  String? manualSource;
  String? urlSource;

  MultiSourceValue({this.manualSource, this.urlSource});

  Future<String> value<T>(T request) async {
    if (urlSource != null) {
      return http
          .post(Uri.parse(urlSource!),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Access-Control-Allow-Origin': '*',
              },
              body: jsonEncode(request))
          .then(
        (response) {
          if (response.statusCode == 200) {
            return response.body;
          } else {
            return "Error getting value";
          }
        },
      );
    } else {
      return manualSource ?? "";
    }
  }

  factory MultiSourceValue.fromJson(Map<String, dynamic> json) =>
      _$MultiSourceValueFromJson(json);

  Map<String, dynamic> toJson() => _$MultiSourceValueToJson(this);
}
