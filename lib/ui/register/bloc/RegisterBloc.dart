import 'package:baykurs/ui/register/bloc/RegisterEvent.dart';
import 'package:baykurs/ui/register/bloc/RegisterState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../repository/user_repository.dart';
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
        String errorMessage = "Bir hata oluştu";

        if (e is DioException && e.response?.data != null) {
          final responseData = e.response?.data;

          if (responseData['errors'] != null) {
            errorMessage = responseData['errors']
                .entries
                .map((entry) =>
                    "${entry.key}: ${(entry.value as List).join(", ")}")
                .join("\n");
          } else if (responseData['message'] != null) {
            errorMessage = responseData['message'];
          }
        }
        emit(RegisterError(errorMessage));
      }
    });
  }
}
