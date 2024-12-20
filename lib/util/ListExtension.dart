extension NullOrEmptyListExtension<T> on List<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }
}