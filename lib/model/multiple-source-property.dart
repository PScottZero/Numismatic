class MultiSourceValue<T> {
  T? manualSource;
  String? urlSource;

  T? get value {
    if (urlSource != null) {
    } else {
      return manualSource;
    }
  }

  MultiSourceValue({this.manualSource, this.urlSource});
}
