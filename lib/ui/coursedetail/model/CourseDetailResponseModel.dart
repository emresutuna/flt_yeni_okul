import 'package:intl/intl.dart';

class CourseDetailResponseModel {
  final bool status;
  final CourseDetail data;

  CourseDetailResponseModel({required this.status, required this.data});

  factory CourseDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailResponseModel(
      status: json['status'],
      data: CourseDetail.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class CourseDetail {
  final int id;
  final int schoolId;
  final int lessonId;
  final int teacherId;
  final DateTime startDate;
  final DateTime endDate;
  final String classroom;
  final DateTime deadline;
  final double price;
  final int quota;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final School school;
  final Lesson lesson;
  final Teacher teacher;

  CourseDetail({
    required this.id,
    required this.schoolId,
    required this.lessonId,
    required this.teacherId,
    required this.startDate,
    required this.endDate,
    required this.classroom,
    required this.deadline,
    required this.price,
    required this.quota,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.school,
    required this.lesson,
    required this.teacher,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'],
      schoolId: json['school_id'],
      lessonId: json['lesson_id'],
      teacherId: json['teacher_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      classroom: json['classroom'],
      deadline: DateTime.parse(json['deadline']),
      price: json['price'].toDouble(),
      quota: json['quota'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'],
      school: School.fromJson(json['school']),
      lesson: Lesson.fromJson(json['lesson']),
      teacher: Teacher.fromJson(json['teacher']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'lesson_id': lessonId,
      'teacher_id': teacherId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'classroom': classroom,
      'deadline': deadline.toIso8601String(),
      'price': price,
      'quota': quota,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt,
      'school': school.toJson(),
      'lesson': lesson.toJson(),
      'teacher': teacher.toJson(),
    };
  }
  String get formattedStartDate {
    String formattedDate = DateFormat('dd.MM.yyyy').format(startDate);
    String formattedTime = DateFormat('HH:mm').format(startDate);
    return '$formattedDate | Saat: $formattedTime';
  }

  String get formattedEndDate {
    String formattedTime = DateFormat('HH:mm').format(endDate);
    return 'Saat: $formattedTime';
  }

  String get formattedDateRange {
    String start = formattedStartDate;
    String end = formattedEndDate;
    return '$start - $end';
  }
}

class School {
  final int id;
  final int userId;
  final User user;

  School({required this.id, required this.userId, required this.user});

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user.toJson(),
    };
  }
}

class Lesson {
  final int id;
  final String name;
  final String color;

  Lesson({required this.id, required this.name, required this.color});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

class Teacher {
  final int id;
  final int userId;
  final User user;

  Teacher({required this.id, required this.userId, required this.user});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
