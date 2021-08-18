enum CurrencySymbol { CENT, DOLLAR, UNKNOWN }

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

CurrencySymbol fromString(String symbol) {
  switch (symbol) {
    case '\$':
      return CurrencySymbol.DOLLAR;
    case '¢':
      return CurrencySymbol.CENT;
    default:
      return CurrencySymbol.UNKNOWN;
  }
}
