import 'package:yeni_okul/ui/profile/model/ProfileResponse.dart';

abstract class ProfileState {}

class ProfileDefault extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileResponse profileResponse;

  ProfileSuccess(this.profileResponse);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}