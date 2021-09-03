import 'package:numismatic/model/sort_method.dart';

import 'coin.dart';

class CoinComparator {
  static int Function(Coin, Coin) get(SortMethod sortMethod) {
    switch (sortMethod) {
      case SortMethod.type:
        return _compareTypes;
      case SortMethod.year:
        return _compareYears;
      case SortMethod.retailPrice:
        return _compareRetailPrices;
    }
  }

  static int _compareTypes(Coin c1, Coin c2) => _compareNullableStrings(
        c1.type.value,
        c2.type.value,
      );

  static int _compareYears(Coin c1, Coin c2) => _compareNullableStrings(
        c1.year,
        c2.year,
      );

  static int _compareRetailPrices(Coin c1, Coin c2) => _compareNullableStrings(
        c1.retailPrice,
        c2.retailPrice,
      );

  static int _compareNullableStrings(String? s1, String? s2) {
    if (s1 == null && s2 == null) {
      return 0;
    } else if (s2 == null) {
      return 1;
    } else if (s1 == null) {
      return -1;
    } else {
      return s1.compareTo(s2);
    }
  }
}
