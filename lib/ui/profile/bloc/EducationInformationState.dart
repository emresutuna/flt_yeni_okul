import '../model/EducationInformationResponse.dart';

abstract class EducationInformationState {}

class EducationInformationStateDefault extends EducationInformationState {}

class EducationInformationStateLoading extends EducationInformationState {}

class EducationInformationStateSuccess extends EducationInformationState {
  final EducationInformationResponse educationInformationResponse;

  EducationInformationStateSuccess(this.educationInformationResponse);
}
class EducationInformationStateUpdateSuccess extends EducationInformationState {
  final EducationInformationResponse profileResponse;

  EducationInformationStateUpdateSuccess(this.profileResponse);
}

class EducationInformationStateError extends EducationInformationState {
  final String error;

  EducationInformationStateError(this.error);
}
class EducationInformationStateUpdateError extends EducationInformationState {
  final String error;

  EducationInformationStateUpdateError(this.error);
}