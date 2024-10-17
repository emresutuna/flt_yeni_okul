import 'package:bloc/bloc.dart';
import 'package:yeni_okul/repository/lectureRepository.dart';
import 'package:yeni_okul/ui/coursedetail/bloc/CourseDetailEvent.dart';
import 'package:yeni_okul/ui/coursedetail/bloc/CourseDetailState.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final LectureRepository lectureRepository;

  CourseDetailBloc({required this.lectureRepository})
      : super(CourseDetailStateLoading()) {
    on<FetchCourseById>((event, emit) async {
      emit(CourseDetailStateLoading());
      try {
        final result = await lectureRepository.getLessons();
        emit(CourseDetailStateSuccess(result.data!));
      } catch (e) {
        emit(CourseDetailStateError('Failed to fetch courseDetail'));
      }
    });
  }
}
