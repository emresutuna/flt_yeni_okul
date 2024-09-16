import 'package:yeni_okul/ui/companyDetail/model/SchoolDetailResponse.dart';


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