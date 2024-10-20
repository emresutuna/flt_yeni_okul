import 'package:baykurs/ui/register/model/RegisterRequest.dart';

abstract class RegisterEvent {}

class UserRegister extends RegisterEvent {
  final RegisterRequest request;

  UserRegister({
    required this.request,
  });
}