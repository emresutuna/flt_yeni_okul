import '../../../util/BaseCourseModel.dart';

class CourseCoachDetailResponse {
  bool? status;
  List<BaseCourse>? data; // Liste olarak tanımlandı

  CourseCoachDetailResponse({this.status, this.data});

  CourseCoachDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((item) => BaseCourse.fromJson(item))
          .toList();
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((course) => course.toJson()).toList(),
  };
}
