class ResultResponse<T> {
  final T? data;
  final dynamic error;
  final bool isSuccess;

  ResultResponse.success(this.data)
      : error = null,
        isSuccess = true;

  ResultResponse.failure(this.error)
      : data = null,
        isSuccess = false;
}
extension ResultResponseX<T> on ResultResponse<T> {
  void handle({
    required void Function(T data) onSuccess,
    required void Function(dynamic error) onError,
  }) {
    if (isSuccess) {
      onSuccess(data as T);
    } else {
      onError(error);
    }
  }
}