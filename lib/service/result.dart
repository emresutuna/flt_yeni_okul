sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class ResultLoading extends Result {
  final bool isLoading;

  ResultLoading(this.isLoading);
}

class ResultError extends Result<String> {
  final String errorMessage;

  ResultError(this.errorMessage);
}
