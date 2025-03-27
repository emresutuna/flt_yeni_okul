class ResultResponseZ<T> {
  final T? data;
  final String? error;

  ResultResponseZ.success(this.data) : error = null;
  ResultResponseZ.failure(this.error) : data = null;
}