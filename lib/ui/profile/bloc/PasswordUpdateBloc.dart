import 'package:baykurs/repository/userRepository.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateEvent.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateState.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  final UserRepository userRepository;

  PasswordUpdateBloc({required this.userRepository})
      : super(UserUpdateDefault()) {
    on<UserUpdateRequest>((event, emit) async {
      emit(UserUpdateLoading());
      try {
        final result = await userRepository.updateUserInfo(event.request);

        if (result.error != null) {
          emit(UserUpdateError(result.error ?? "Bir hata oluştu"));
        } else {

          emit(UserUpdateSuccess(result.data!));
        }
      } catch (e) {
        String errorMessage;
        if (e is DioException && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? "Bir hata oluştu";
        } else {
          errorMessage = "Bir hata oluştu";
        }

        emit(UserUpdateError(errorMessage));
      }
    });
  }
}