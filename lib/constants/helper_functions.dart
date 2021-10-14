import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class HelperFunctions {
  static Tuple2<String?, String?> yearAndMintMarkFromVariation(
    String variation,
  ) {
    var year = variation.split(' ')[0];
    var yearInt = int.tryParse(year);
    if (yearInt == null) {
      var yearAndMintMark = year.split('-');
      if (yearAndMintMark.length == 2) {
        return Tuple2(yearAndMintMark.first, yearAndMintMark.last);
      } else {
        return const Tuple2(null, null);
      }
    } else {
      return Tuple2(year, null);
    }
  }

  static MaterialStateProperty<T> msp<T>(T property) =>
      MaterialStateProperty.all<T>(property);
}
