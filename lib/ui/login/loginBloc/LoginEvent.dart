
import '../model/LoginRequest.dart';

abstract class LoginEvent {}

class UserLogin extends LoginEvent {
  final LoginRequest request;

  UserLogin({
    required this.request,
  });
}