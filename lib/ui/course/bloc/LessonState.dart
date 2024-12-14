import 'package:baykurs/ui/courseBundle/model/CourseBundleResponse.dart';
import 'package:baykurs/ui/teacherCoach/model/CourseCoachResponse.dart';
import 'package:baykurs/ui/teacherCoachDetail/model/CourseCoachDetailResponse.dart';

import '../model/CourseModel.dart';

abstract class LessonState {}

class LessonStateLoading extends LessonState {}

class LessonStateSuccess extends LessonState {
  final CourseResponse lessonResponse;

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
  final CourseBundleResponse courseBundleResponse;

  CourseBundleSuccess(this.courseBundleResponse);
}

class LessonStateError extends LessonState {
  final String error;

  LessonStateError(this.error);
}
