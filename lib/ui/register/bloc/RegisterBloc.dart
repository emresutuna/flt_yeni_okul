import 'package:baykurs/ui/login/model/UserRegisterModel.dart';
import 'package:baykurs/ui/register/bloc/RegisterEvent.dart';
import 'package:baykurs/ui/register/bloc/RegisterState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../repository/userRepository.dart';
import '../../../util/SharedPrefHelper.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterDefault()) {
    on<UserRegister>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await userRepository.postRegister(event.request);

        if (result.error != null) {
          emit(RegisterError(result.error ?? "Bir hata oluştu"));
        } else {
          saveToken(result.data?.token ?? "");
          saveData(result.data?.user?.name ?? "", "user_name");
          emit(RegisterSuccess(result.data!));
        }
      } catch (e) {
        String errorMessage;
        if (e is DioException && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? "Bir hata oluştu";
        } else {
          errorMessage = "Bir hata oluştu";
        }

        emit(RegisterError(errorMessage));
      }
    });
  }

}
