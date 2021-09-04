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
      c1.type.value, c2.type.value, _compareYears, c1, c2);

  static int _compareYears(Coin c1, Coin c2) =>
      _compareNullableStrings(c1.year, c2.year, _compareMintMarks, c1, c2);

  static int _compareMintMarks(Coin c1, Coin c2) =>
      _compareNullableStrings(c1.mintMark, c2.mintMark);

  static int _compareRetailPrices(Coin c1, Coin c2) => _compareNullableStrings(
      c1.retailPrice, c2.retailPrice, _compareTypes, c1, c2);

  static int _compareNullableStrings(
    String? s1,
    String? s2, [
    int Function(Coin, Coin)? equalsFunc,
    Coin? c1,
    Coin? c2,
  ]) {
    if (s1 == null && s2 == null) {
      return equalsFunc != null ? equalsFunc(c1!, c2!) : 0;
    } else if (s2 == null) {
      return 1;
    } else if (s1 == null) {
      return -1;
    } else {
      var compare = s1.compareTo(s2);
      if (compare == 0 && equalsFunc != null) return equalsFunc(c1!, c2!);
      return compare;
    }
  }
}
