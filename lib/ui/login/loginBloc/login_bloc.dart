import 'package:bloc/bloc.dart';


import '../../../repository/user_repository.dart';
import '../../../util/SharedPrefHelper.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginDefault()) {
    // Registering event handler for FetchUsers event
    on<UserLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        final result = await userRepository.postLogin(event.request);
        saveToken(result.data?.token ?? "");
        saveData(result.data?.user?.name ?? "", "user_name");
        emit(LoginSuccess(result.data!));
      } catch (e) {
        emit(LoginError('Failed to fetch users'));
      }
    });
  }
}