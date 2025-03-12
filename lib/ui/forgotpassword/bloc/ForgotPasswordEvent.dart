import '../forgot_password_request.dart';

abstract class ForgotPasswordEvent {}

class ForgotPwd extends ForgotPasswordEvent {
  final ForgotPasswordRequest request;

  ForgotPwd({
    required this.request,
  });
}