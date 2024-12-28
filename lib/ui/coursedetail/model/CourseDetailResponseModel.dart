import 'dart:convert';

import '../../../util/BaseCourseModel.dart';

class CourseDetailResponse {
  bool? status;
  CourseDetailData? data;

  CourseDetailResponse({this.status, this.data});

  CourseDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? CourseDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CourseDetailData extends BaseCourse {
  String? classroom;
  String? teacherName;
  String? teacherSurname;
  String? lessonName;
  Lesson? lesson;

  CourseDetailData({
    int? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    int? price,
    int? quota,
    String? schoolName,
    School? school,
    List<Topics>? topics,
    this.classroom,
    this.teacherName,
    this.teacherSurname,
  }) : super(
          id: id,
          title: title,
          description: description,
          startDate: startDate,
          endDate: endDate,
          price: price,
          quota: quota,
          school: school,
          schoolName: schoolName,
          topics: topics,
        );

  CourseDetailData.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    classroom = json['classroom'];
    teacherName = json['teacher_name'];
    teacherSurname = json['teacher_surname'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    schoolName = school?.name; // School nesnesinden name alınır
    if (json['topics'] is List) {
      topics = (json['topics'] as List)
          .map((topic) => Topics.fromJson(topic))
          .toList();
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['classroom'] = classroom;
    data['teacher_name'] = teacherName;
    data['teacher_surname'] = teacherSurname;
    if (lesson != null) {
      data['lesson'] = lesson!.toJson();
    }
    return data;
  }
}
