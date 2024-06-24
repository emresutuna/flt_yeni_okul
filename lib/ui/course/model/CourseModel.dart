import 'package:yeni_okul/ui/company/model/CompanyModel.dart';

class CourseModel {
  int? id;
  int? courseId;
  String? courseName;
  String? courseTitle;
  String? courseDesc;
  String? courseType;
  String? date;
  String? startDate;
  String? endDate;
  bool? hasPackageCourse;
  String? time;
  String? quota;
  String? price;
  String? location;
  Teacher? teacher;
  CompanyModel? company;

  CourseModel(
      {this.id,
      this.courseId,
      this.courseName,
      this.courseTitle,
      this.courseDesc,
      this.courseType,
      this.date,
      this.startDate,
      this.endDate,
      this.hasPackageCourse,
      this.time,
      this.quota,
      this.price,
      this.location,
      this.teacher,
      this.company});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    courseName = json['courseName'];
    courseTitle = json['courseTitle'];
    courseDesc = json['courseDesc'];
    courseType = json['courseType'];
    date = json['date'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    hasPackageCourse = json['hasPackageCourse'];
    time = json['time'];
    quota = json['quota'];
    price = json['price'];
    location = json['location'];
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['courseTitle'] = courseTitle;
    data['courseDesc'] = courseDesc;
    data['courseType'] = courseType;
    data['date'] = date;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['hasPackageCourse'] = hasPackageCourse;
    data['time'] = time;
    data['quota'] = quota;
    data['price'] = price;
    data['location'] = location;
    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}
