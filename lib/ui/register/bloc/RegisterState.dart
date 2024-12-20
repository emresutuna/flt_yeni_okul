import 'package:baykurs/ui/register/model/RegisterResponse.dart';

abstract class RegisterState {}

class RegisterDefault extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse registerResponse;

  RegisterSuccess(this.registerResponse);
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}
