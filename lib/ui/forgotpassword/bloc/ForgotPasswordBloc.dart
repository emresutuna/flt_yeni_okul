import 'package:baykurs/ui/forgotpassword/bloc/ForgotPasswordEvent.dart';
import 'package:baykurs/ui/forgotpassword/bloc/ForgotPasswordState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../repository/user_repository.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UserRepository userRepository;

  ForgotPasswordBloc({required this.userRepository}) : super(ForgotPasswordDefault()) {
    on<ForgotPwd>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        final result = await userRepository.postForgotPassword(event.request);

        if (result.error != null) {
          emit(ForgotPasswordError(result.error ?? "Bir hata oluştu"));
        } else {
          emit(ForgotPasswordSuccess(result.data!));
        }
      } catch (e) {
        String errorMessage;
        if (e is DioException && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? "Bir hata oluştu";
        } else {
          errorMessage = "Bir hata oluştu";
        }

        emit(ForgotPasswordError(errorMessage));
      }
    });
  }

}