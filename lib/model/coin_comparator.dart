import 'package:numismatic/model/sort_method.dart';

import 'coin.dart';

class CoinComparator {
  static SortMethod sortMethod = SortMethod.type;
  static bool ascending = true;
  static List<int Function(Coin, Coin)> _compareFuncs = [];

  static setSortMethod(SortMethod sortMethod) {
    CoinComparator.sortMethod = sortMethod;
    switch (sortMethod) {
      case SortMethod.type:
        _compareFuncs = [
          _compareTypes,
          _compareYears,
          _compareMintMarks,
        ];
        break;
      case SortMethod.year:
        _compareFuncs = [
          _compareYears,
          _compareMintMarks,
          _compareTypes,
        ];
        break;
      case SortMethod.retailPrice:
        _compareFuncs = [
          _compareRetailPrices,
          _compareTypes,
          _compareYears,
          _compareMintMarks,
        ];
        break;
    }
  }

  static int comparator(Coin c1, Coin c2, [int index = 0]) {
    if (index < _compareFuncs.length) {
      var comparison = _compareFuncs[index](c1, c2);
      return comparison == 0 ? comparator(c1, c2, index + 1) : comparison;
    } else {
      return 0;
    }
  }

  static int _compareTypes(Coin c1, Coin c2) =>
      _compareNullable(c1.type.value, c2.type.value);

  static int _compareYears(Coin c1, Coin c2) => _compareNullable(
        double.tryParse(c1.year ?? ''),
        double.tryParse(c2.year ?? ''),
      );

  static int _compareMintMarks(Coin c1, Coin c2) =>
      _compareNullable(c1.mintMark, c2.mintMark);

  static int _compareRetailPrices(Coin c1, Coin c2) => _compareNullable(
        double.tryParse(
          c1.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
        ),
        double.tryParse(
          c2.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
        ),
      );

  static int _compareNullable<T>(T? first, T? second) {
    if (first == null && second == null) {
      return 0;
    } else if (second == null) {
      return ascending ? 1 : -1;
    } else if (first == null) {
      return ascending ? -1 : 1;
    } else {
      if (first is String && second is String) {
        return first.compareTo(second) * (ascending ? 1 : -1);
      } else {
        return (first as double).compareTo(second as double) *
            (ascending ? 1 : -1);
      }
    }
  }
}
