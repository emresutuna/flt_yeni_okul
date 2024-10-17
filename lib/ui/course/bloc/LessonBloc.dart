import 'package:bloc/bloc.dart';
import 'package:yeni_okul/repository/lectureRepository.dart';
import 'package:yeni_okul/ui/course/bloc/LessonEvent.dart';
import 'package:yeni_okul/ui/course/bloc/LessonState.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final LectureRepository lectureRepository;

  LessonBloc({required this.lectureRepository}) : super(LessonStateLoading()) {
    // Registering event handler for FetchLesson event
    on<FetchLesson>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result = await lectureRepository.getLessons();
        emit(LessonStateSuccess(result.data!));
      } catch (e) {
        emit(LessonStateError('Failed to fetch users'));
      }
    });
  }
}