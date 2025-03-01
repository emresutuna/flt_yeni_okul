
import 'package:baykurs/ui/profile/model/DeleteAccountResponse.dart';
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
class DeleteAccountSuccess extends ProfileState {
  final DeleteAccountResponse deleteAccountResponse;

  DeleteAccountSuccess(this.deleteAccountResponse);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
class LogoutError extends ProfileState {
  final String error;

  LogoutError(this.error);
}
class DeleteAccountError extends ProfileState {
  final String error;

  DeleteAccountError(this.error);
}