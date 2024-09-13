class ResultResponse<T> {
  final T? data;
  final String? error;

  ResultResponse.success(this.data) : error = null;
  ResultResponse.failure(this.error) : data = null;
}