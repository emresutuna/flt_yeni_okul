import '../../../util/DateExtension.dart';
import 'CourseCoachDetailResponse.dart';

class CourseCoachDetailUiModel {
  int id;
  int price;
  CourseUiModel course;
  String title;
  String description;

  CourseCoachDetailUiModel({
    required this.id,
    required this.price,
    required this.course,
    required this.title,
    required this.description,
  });

  factory CourseCoachDetailUiModel.fromEntity(CourseCoachDetail entity) {
    return CourseCoachDetailUiModel(
      id: entity.id ?? 0,
      price: entity.price ?? 0,
      course: entity.course != null
          ? CourseUiModel.fromEntity(entity.course!)
          : CourseUiModel.defaultModel(),
      title: entity.title ?? "No Title",
      description: entity.description ?? "No Description",
    );
  }
}

class CourseUiModel {
  int id;
  DateTime startDate;
  String endDate;
  String classroom;
  int quota;
  List<TopicsUiModel> topics;
  SchoolUiModel school;
  String lesson;
  String teacherName;
  String teacherSurname;

  CourseUiModel({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.classroom,
    required this.quota,
    required this.topics,
    required this.school,
    required this.lesson,
    required this.teacherName,
    required this.teacherSurname,
  });

  factory CourseUiModel.fromEntity(Course entity) {
    return CourseUiModel(
      id: entity.id ?? 0,
      startDate: DateTime.parse(entity.startDate ?? "1970-01-01T00:00:00Z"),
      endDate: entity.endDate ?? "Unknown End Date",
      classroom: entity.classroom ?? "Unknown Classroom",
      quota: entity.quota ?? 0,
      topics:
          entity.topics?.map((e) => TopicsUiModel.fromEntity(e)).toList() ?? [],
      school: entity.school != null
          ? SchoolUiModel.fromEntity(entity.school!)
          : SchoolUiModel.defaultModel(),
      lesson: entity.lesson ?? "Unknown Lesson",
      teacherName: entity.teacherName ?? "Unknown Teacher Name",
      teacherSurname: entity.teacherSurname ?? "Unknown Teacher Surname",
    );
  }

  String get formattedStartDate => formatStartDate(startDate);

  factory CourseUiModel.defaultModel() {
    return CourseUiModel(
      id: 0,
      startDate: DateTime.parse("1970-01-01T00:00:00Z"),
      endDate: "Unknown End Date",
      classroom: "Unknown Classroom",
      quota: 0,
      topics: [],
      school: SchoolUiModel.defaultModel(),
      lesson: "Unknown Lesson",
      teacherName: "Unknown Teacher Name",
      teacherSurname: "Unknown Teacher Surname",
    );
  }
}

class TopicsUiModel {
  int id;
  String name;

  TopicsUiModel({
    required this.id,
    required this.name,
  });

  factory TopicsUiModel.fromEntity(Topics entity) {
    return TopicsUiModel(
      id: entity.id ?? 0,
      name: entity.name ?? "Unknown Topic",
    );
  }
}

class SchoolUiModel {
  int id;
  String name;
  String address;
  String latitude;
  String longitude;
  String cityName;
  String provinceName;

  SchoolUiModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.provinceName,
  });

  factory SchoolUiModel.fromEntity(School entity) {
    return SchoolUiModel(
      id: entity.id ?? 0,
      name: entity.name ?? "Unknown School",
      address: entity.address ?? "Unknown Address",
      latitude: entity.latitude ?? "0.0",
      longitude: entity.longitude ?? "0.0",
      cityName: entity.cityName ?? "Unknown City",
      provinceName: entity.provinceName ?? "Unknown Province",
    );
  }

  factory SchoolUiModel.defaultModel() {
    return SchoolUiModel(
      id: 0,
      name: "Unknown School",
      address: "Unknown Address",
      latitude: "0.0",
      longitude: "0.0",
      cityName: "Unknown City",
      provinceName: "Unknown Province",
    );
  }
}
