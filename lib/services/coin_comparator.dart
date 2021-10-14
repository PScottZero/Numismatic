import 'package:numismatic/model/sort_method.dart';

import '../model/coin.dart';

class CoinComparator {
  static SortMethod sortMethod = SortMethod.denomination;
  static bool ascending = false;
  static List<int Function(Coin, Coin, int)> _compareFuncs = [];

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
      case SortMethod.denomination:
        ascending = false;
        _compareFuncs = [
          _compareDenominations,
          _compareYears,
          _compareMintMarks,
        ];
        break;
      case SortMethod.retailPrice:
        ascending = false;
        _compareFuncs = [
          _compareRetailPrices,
          _compareTypes,
          _compareYears,
          _compareMintMarks,
        ];
        break;
      case SortMethod.dateAdded:
        ascending = false;
        _compareFuncs = [_compareDates];
    }
  }

  static int comparator(Coin c1, Coin c2, [int index = 0]) {
    if (index < _compareFuncs.length) {
      var comparison = _compareFuncs[index](c1, c2, index);
      return comparison == 0 ? comparator(c1, c2, index + 1) : comparison;
    } else {
      return 0;
    }
  }

  static int _compareTypes(Coin c1, Coin c2, int index) =>
      _compareNullable(c1.type.value, c2.type.value, index);

  static int _compareYears(Coin c1, Coin c2, int index) => _compareNullable(
        double.tryParse(c1.year ?? ''),
        double.tryParse(c2.year ?? ''),
        index,
      );

  static int _compareMintMarks(Coin c1, Coin c2, int index) =>
      _compareNullable(c1.mintMark, c2.mintMark, index);

  static int _compareDenominations(Coin c1, Coin c2, int index) =>
      _compareNullable(c1.denomination, c2.denomination, index);

  static int _compareRetailPrices(Coin c1, Coin c2, int index) =>
      _compareNullable(
        double.tryParse(
          c1.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
        ),
        double.tryParse(
          c2.retailPrice?.replaceAll('\$', '').replaceAll(',', '') ?? '',
        ),
        index,
      );

  static int _compareDates(Coin c1, Coin c2, int index) => ascending
      ? (c1.dateAdded ?? DateTime.now())
          .compareTo(c2.dateAdded ?? DateTime.now())
      : (c2.dateAdded ?? DateTime.now())
          .compareTo(c1.dateAdded ?? DateTime.now());

  static int _compareNullable<T>(T? first, T? second, int index) {
    if (first == null && second == null) {
      return 0;
    } else if (second == null) {
      return -1;
    } else if (first == null) {
      return 1;
    } else {
      if (first is String && second is String) {
        return first.compareTo(second) *
            ((ascending && index == 0) || index != 0 ? 1 : -1);
      } else {
        return (first as double).compareTo(second as double) *
            ((ascending && index == 0) || index != 0 ? 1 : -1);
      }
    }
  }
}
