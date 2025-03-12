import '../../../util/BaseCourseModel.dart';

class TimeSheetResponse {
  bool? status;
  List<TimeSheet>? data;

  TimeSheetResponse({this.status, this.data});

  TimeSheetResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TimeSheet>[];
      json['data'].forEach((v) {
        data!.add(TimeSheet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeSheet {
  int? id;
  int? schoolId;
  int? lessonId;
  int? teacherId;
  String? startDate;
  String? endDate;
  String? classroom;
  String? deadline;
  num? price;
  int? quota;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  School? school;
  Lesson? lesson;
  Teacher? teacher;

  TimeSheet({
    this.id,
    this.schoolId,
    this.lessonId,
    this.teacherId,
    this.startDate,
    this.endDate,
    this.classroom,
    this.deadline,
    this.price,
    this.quota,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.school,
    this.lesson,
    this.teacher,
  });

  TimeSheet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    lessonId = json['lesson_id'];
    teacherId = json['teacher_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    classroom = json['classroom'];
    deadline = json['deadline'];
    price = json['price'];
    quota = json['quota'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    // Safely handle null values for nested objects
    if (json['school'] != null && json['school'] is Map<String, dynamic>) {
      school = School.fromJson(json['school']);
    }

    if (json['lesson'] != null && json['lesson'] is Map<String, dynamic>) {
      lesson = Lesson.fromJson(json['lesson']);
    }

    if (json['teacher'] != null && json['teacher'] is Map<String, dynamic>) {
      teacher = Teacher.fromJson(json['teacher']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['school_id'] = schoolId;
    data['lesson_id'] = lessonId;
    data['teacher_id'] = teacherId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['classroom'] = classroom;
    data['deadline'] = deadline;
    data['price'] = price;
    data['quota'] = quota;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;

    if (school != null) {
      data['school'] = school!.toJson();
    }
    if (lesson != null) {
      data['lesson'] = lesson!.toJson();
    }
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    return data;
  }
}
