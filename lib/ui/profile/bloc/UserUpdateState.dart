
import 'package:baykurs/ui/profile/model/UserUpdateResponse.dart';

abstract class UserUpdateState {}

class UserUpdateDefault extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {
  final UserUpdateResponse profileResponse;

  UserUpdateSuccess(this.profileResponse);
}

class UserUpdateError extends UserUpdateState {
  final String error;

  UserUpdateError(this.error);
}