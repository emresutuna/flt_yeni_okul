import 'package:baykurs/ui/courseBundleDetail/model/course_bundle_detail_response.dart';
import 'package:baykurs/ui/coursedetail/model/course_detail_response_model.dart';
import 'package:baykurs/ui/teacherCoachDetail/model/CourseCoachDetailResponse.dart';


abstract class CourseDetailState {}


class CourseDetailStateLoading extends CourseDetailState {}

class CourseDetailStateSuccess extends CourseDetailState {
  final CourseDetailResponse courseResponseModel;

  CourseDetailStateSuccess(this.courseResponseModel);
}
class CourseBundleDetailStateSuccess extends CourseDetailState {
  final CourseBundleDetailResponse courseResponseModel;

  CourseBundleDetailStateSuccess(this.courseResponseModel);
}
class CourseCoachDetailSuccess extends CourseDetailState {
  final CourseCoachDetailResponse courseCoachResponse;

  CourseCoachDetailSuccess(this.courseCoachResponse);
}

class CourseDetailStateError extends CourseDetailState {
  final String error;

  CourseDetailStateError(this.error);
}
