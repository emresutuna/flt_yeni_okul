import 'package:baykurs/ui/forgotpassword/ForgotPasswordResponse.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordDefault extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final ForgotPasswordResponse response;

  ForgotPasswordSuccess(this.response);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;

  ForgotPasswordError(this.error);
}