
import '../model/login_response.dart';

abstract class LoginState {}

class LoginDefault extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}