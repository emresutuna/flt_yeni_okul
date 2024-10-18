import 'package:bloc/bloc.dart';

import '../../../repository/lectureRepository.dart';
import 'CourseDetailEvent.dart';
import 'CourseDetailState.dart';


class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final LectureRepository lectureRepository;

  CourseDetailBloc({required this.lectureRepository})
      : super(CourseDetailStateLoading()) {
    on<FetchCourseById>((event, emit) async {
      emit(CourseDetailStateLoading());
      try {
        final result = await lectureRepository.getCourseById(event.id);
        emit(CourseDetailStateSuccess(result.data!));
      } catch (e) {
        emit(CourseDetailStateError('Failed to fetch courseDetail'));
      }
    });
  }
}
