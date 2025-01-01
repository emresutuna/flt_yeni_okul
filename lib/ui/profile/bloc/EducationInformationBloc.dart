import 'package:baykurs/ui/profile/bloc/EducationInformationState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../repository/userRepository.dart';
import 'EducationInformationEvent.dart';

class EducationInformationBloc
    extends Bloc<EducationInformationEvent, EducationInformationState> {
  final UserRepository userRepository;

  EducationInformationBloc({required this.userRepository})
      : super(EducationInformationStateDefault()) {
    on<FetchEducationInformation>((event, emit) async {
      emit(EducationInformationStateLoading());
      try {
        /*
        final result = await userRepository.updateUserInfo(event.request);

        if (result.error != null) {
          emit(UserUpdateError(result.error ?? "Bir hata oluştu"));
        } else {

          emit(EducationInformationStateSuccess(result.data!));
        }

         */
      } catch (e) {
        String errorMessage;
        if (e is DioException && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? "Bir hata oluştu";
        } else {
          errorMessage = "Bir hata oluştu";
        }

        emit(EducationInformationStateUpdateError(errorMessage));
      }
    });
  }
}
