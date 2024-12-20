import 'package:bloc/bloc.dart';

import '../../../repository/lectureRepository.dart';
import 'LessonEvent.dart';
import 'LessonState.dart';

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
        emit(LessonStateError('Failed to fetch Course'));
      }
    });

    on<FetchCourseCoach>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result = await lectureRepository.getCourseCoach();
        emit(CourseCoachSuccess((result.data!)));
      } catch (e) {
        emit(LessonStateError('Failed to fetch Course Coach'));
      }
    });

    on<FetchLessonWithFilter>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result =
            await lectureRepository.getCourseByFilter(event.courseFilter);
        emit(LessonStateSuccess(result.data!));
      } catch (e) {
        emit(LessonStateError('Sonuç Bulunamadı'));
      }
    });

    on<FetchCourseCoachWithFilter>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result =
            await lectureRepository.getCourseCoachByFilter(event.courseFilter);
        emit(CourseCoachSuccess(result.data!));
      } catch (e) {
        emit(LessonStateError('Sonuç Bulunamadı'));
      }
    });

    on<FetchCourseBundle>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result = await lectureRepository.getCourseBundle();
        emit(CourseBundleSuccess(result.data!));
      } catch (e) {
        emit(LessonStateError('Sonuç Bulunamadı'));
      }
    });

    on<FetchCourseBundleWithFilter>((event, emit) async {
      emit(LessonStateLoading());
      try {
        final result = await lectureRepository.getCourseBundleWithFilter(event.courseFilter);
        emit(CourseBundleSuccess(result.data!));
      } catch (e) {
        emit(LessonStateError('Sonuç Bulunamadı'));
      }
    });
  }
}
