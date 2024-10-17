
import '../model/CourseModel.dart';

abstract class LessonState {}


class LessonStateLoading extends LessonState {}

class LessonStateSuccess extends LessonState {
  final CourseResponseModel lessonResponse;

  LessonStateSuccess(this.lessonResponse);
}

class LessonStateError extends LessonState {
  final String error;

  LessonStateError(this.error);
}
