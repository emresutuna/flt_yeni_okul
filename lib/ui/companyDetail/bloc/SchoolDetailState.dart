import '../model/SchoolDetailResponse.dart';

abstract class SchoolDetailState {}

class SchoolDetailDefault extends SchoolDetailState {}

class SchoolDetailLoading extends SchoolDetailState {}

class SchoolDetailSuccess extends SchoolDetailState {
  final SchoolDetailResponse schoolResponse;

  SchoolDetailSuccess(this.schoolResponse);
}

class SchoolDetailError extends SchoolDetailState {
  final String error;

  SchoolDetailError(this.error);
}

class FavoriteError extends SchoolDetailState {
  final String error;

  FavoriteError(this.error);
}
