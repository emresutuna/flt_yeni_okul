part of 'authentication_bloc.dart';


abstract class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];

}

class SignUpUser extends AuthenticationEvent {
  final UserRegisterModel userRegisterModel;

  const SignUpUser(this.userRegisterModel);

  @override
  List<UserRegisterModel> get props => [userRegisterModel];
}


class SignOut extends AuthenticationEvent {}