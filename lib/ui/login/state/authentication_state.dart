part of 'authentication_bloc.dart';



abstract class AuthenticationState {
  const AuthenticationState();

  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessState extends AuthenticationState {
  final UserRegisterModel user;

  const AuthenticationSuccessState(this.user);
  @override
  List<Object> get props => [user];
}
class AuthenticationFailureState extends AuthenticationState {
  final String errorMessage;

  const AuthenticationFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}