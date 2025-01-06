import 'package:baykurs/ui/profile/bloc/EducationInformationState.dart';
import 'package:bloc/bloc.dart';
import '../../../repository/userRepository.dart';
import '../../../service/HandleApiException.dart';
import 'EducationInformationEvent.dart';

class EducationInformationBloc
    extends Bloc<EducationInformationEvent, EducationInformationState> {
  final UserRepository userRepository;

  EducationInformationBloc({required this.userRepository})
      : super(EducationInformationStateLoading()) {
    on<FetchEducationInformation>((event, emit) async {
      emit(EducationInformationStateLoading());
      try {
        final result = await userRepository.getEducationInfo();

        if (result.error != null) {
          emit(EducationInformationStateError(
              result.error ?? "Bir hata oluştu"));
        } else {
          emit(EducationInformationStateSuccess(result.data!));
        }
      } catch (e) {
        emit(EducationInformationStateError(handleGeneralException(e)));
      }
    });
    on<UpdateEducationInformation>((event, emit) async {
      emit(EducationInformationStateLoading());
      try {
        final result = await userRepository.updateEducationInfo(event.request);
        if (result.error != null) {
          emit(EducationInformationStateError(
              result.error ?? "Bir hata oluştu"));
        } else {
          emit(EducationInformationStateUpdateSuccess(result.data!));
        }
      } catch (e) {
        emit(EducationInformationStateUpdateError(handleGeneralException(e)));
      }
    });
  }
}
