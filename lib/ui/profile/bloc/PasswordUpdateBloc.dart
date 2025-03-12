import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateEvent.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service/handle_api_exception.dart';

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
        emit(UserUpdateError(handleGeneralException(e)));
      }
    });

  }
}