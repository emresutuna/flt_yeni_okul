
import 'package:baykurs/ui/profile/model/LogoutResponse.dart';

import '../model/ProfileResponse.dart';

abstract class ProfileState {}

class ProfileDefault extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileResponse profileResponse;

  ProfileSuccess(this.profileResponse);
}
class LogoutSuccess extends ProfileState {
  final LogoutResponse profileResponse;

  LogoutSuccess(this.profileResponse);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
class LogoutError extends ProfileState {
  final String error;

  LogoutError(this.error);
}