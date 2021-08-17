enum CurrencySymbol { CENT, DOLLAR }

extension CurrencySymbolExtension on CurrencySymbol {
  String get symbol {
    switch (this) {
      case CurrencySymbol.CENT:
        return '¢';
      case CurrencySymbol.DOLLAR:
        return '\$';
      default:
        return '';
    }
  }
}
