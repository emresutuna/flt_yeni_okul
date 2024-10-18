
import '../model/SchoolResponse.dart';

abstract class SchoolState {}

class SchoolDefault extends SchoolState {}

class SchoolLoading extends SchoolState {}

class SchoolSuccess extends SchoolState {
  final SchoolResponse schoolResponse;

  SchoolSuccess(this.schoolResponse);
}

class SchoolError extends SchoolState {
  final String error;

  SchoolError(this.error);
}
