
import 'package:yeni_okul/ui/course/model/CourseModel.dart';

abstract class CourseDetailState {}


class CourseDetailStateLoading extends CourseDetailState {}

class CourseDetailStateSuccess extends CourseDetailState {
  final CourseResponseModel courseResponseModel;

  CourseDetailStateSuccess(this.courseResponseModel);
}

class CourseDetailStateError extends CourseDetailState {
  final String error;

  CourseDetailStateError(this.error);
}
