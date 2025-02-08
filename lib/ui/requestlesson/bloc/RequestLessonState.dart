
import '../model/CourseRequestResponse.dart';

abstract class RequestLessonState {}

class RequestLessonDefault extends RequestLessonState {}

class RequestLessonLoading extends RequestLessonState {}

class RequestLessonSuccess extends RequestLessonState {
  final RequestCourseResponseModel responseModel;

  RequestLessonSuccess(this.responseModel);
}

class RequestLessonError extends RequestLessonState {
  final String error;

  RequestLessonError(this.error);
}