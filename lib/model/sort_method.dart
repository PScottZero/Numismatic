enum SortMethod { type, year, retailPrice }

extension SortMethodExtension on SortMethod {
  String string() {
    switch (this) {
      case SortMethod.type:
        return 'Type';
      case SortMethod.year:
        return 'Year';
      case SortMethod.retailPrice:
        return 'Retail Price';
    }
  }
}
