import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/ui/teacherCoachDetail/model/CourseCoachDetailResponse.dart';

import '../model/CourseModel.dart';

abstract class LessonState {}

class LessonStateLoading extends LessonState {}

class LessonStateSuccess extends LessonState {
  final CourseResponseModel lessonResponse;

  LessonStateSuccess(this.lessonResponse);
}

class CourseCoachSuccess extends LessonState {
  final CourseCoachResponse courseCoachResponse;

  CourseCoachSuccess(this.courseCoachResponse);
}

class CourseCoachDetailSuccess extends LessonState {
  final CourseCoachDetailResponse courseCoachResponse;

  CourseCoachDetailSuccess(this.courseCoachResponse);
}
class CourseBundleSuccess extends LessonState {
  final CourseCoachDetailResponse courseCoachResponse;

  CourseBundleSuccess(this.courseCoachResponse);
}

class LessonStateError extends LessonState {
  final String error;

  LessonStateError(this.error);
}
