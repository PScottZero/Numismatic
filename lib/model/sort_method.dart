enum SortMethod { dateAdded, denomination, retailPrice, type, year }

extension SortMethodExtension on SortMethod {
  String string() {
    switch (this) {
      case SortMethod.type:
        return 'Type';
      case SortMethod.year:
        return 'Year';
      case SortMethod.denomination:
        return 'Denomination';
      case SortMethod.retailPrice:
        return 'Retail Price';
      case SortMethod.dateAdded:
        return 'Date Added';
    }
  }
}
