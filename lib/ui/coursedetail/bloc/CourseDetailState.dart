

import 'package:baykurs/ui/coursedetail/model/CourseDetailResponseModel.dart';


abstract class CourseDetailState {}


class CourseDetailStateLoading extends CourseDetailState {}

class CourseDetailStateSuccess extends CourseDetailState {
  final CourseDetailResponseModel courseResponseModel;

  CourseDetailStateSuccess(this.courseResponseModel);
}

class CourseDetailStateError extends CourseDetailState {
  final String error;

  CourseDetailStateError(this.error);
}
