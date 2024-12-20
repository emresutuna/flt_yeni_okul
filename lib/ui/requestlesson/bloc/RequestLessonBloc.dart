import 'package:baykurs/ui/requestlesson/bloc/RequestLessonEvent.dart';
import 'package:baykurs/ui/requestlesson/bloc/RequestLessonState.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../repository/userRepository.dart';

class RequestLessonBloc extends Bloc<RequestLessonEvent,RequestLessonState> {
  final UserRepository userRepository;

  RequestLessonBloc({required this.userRepository}) : super(RequestLessonDefault()) {
    on<RequestLesson>((event, emit) async {
      emit(RequestLessonLoading());
      try {
        final result = await userRepository.courseRequest(event.request);

        if (result.error != null) {
          emit(RequestLessonError(result.error ?? "Bir hata oluştu"));
        } else {

          emit(RequestLessonSuccess(result.data!));
        }
      } catch (e) {
        String errorMessage;
        if (e is DioException && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? "Bir hata oluştu";
        } else {
          errorMessage = "Bir hata oluştu";
        }

        emit(RequestLessonError(errorMessage));
      }
    });
  }

}