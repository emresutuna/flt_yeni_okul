class CourseResponseModel {
  final bool? status; // Changed to nullable
  final CourseData? data; // Changed to nullable

  CourseResponseModel({
    this.status,
    this.data,
  });

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) {
    return CourseResponseModel(
      status: json['status'],
      data: json['data'] != null ? CourseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toJson(),
    };
  }
}

class CourseData {
  final List<Course>? courses; // Changed to nullable
  final String? path; // Changed to nullable
  final int? perPage; // Changed to nullable
  final String? nextCursor; // Changed to nullable
  final String? nextPageUrl; // Changed to nullable
  final String? prevCursor; // Changed to nullable
  final String? prevPageUrl; // Changed to nullable

  CourseData({
    this.courses,
    this.path,
    this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<Course>? coursesList = list?.map((i) => Course.fromJson(i)).toList();

    return CourseData(
      courses: coursesList,
      path: json['path'],
      perPage: json['per_page'],
      nextCursor: json['next_cursor'],
      nextPageUrl: json['next_page_url'],
      prevCursor: json['prev_cursor'],
      prevPageUrl: json['prev_page_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': courses?.map((course) => course.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'next_cursor': nextCursor,
      'next_page_url': nextPageUrl,
      'prev_cursor': prevCursor,
      'prev_page_url': prevPageUrl,
    };
  }
}

class Course {
  final int? id; // Changed to nullable
  final int? schoolId; // Changed to nullable
  final int? lessonId; // Changed to nullable
  final int? teacherId; // Changed to nullable
  final DateTime? startDate; // Changed to nullable
  final DateTime? endDate; // Changed to nullable
  final String? classroom; // Changed to nullable
  final DateTime? deadline; // Changed to nullable
  final double? price; // Changed to nullable
  final int? quota; // Changed to nullable
  final DateTime? createdAt; // Changed to nullable
  final DateTime? updatedAt; // Changed to nullable
  final String? deletedAt; // Changed to nullable
  final School? school; // Changed to nullable
  final Lesson? lesson; // Changed to nullable
  final Teacher? teacher; // Changed to nullable

  Course({
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

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      schoolId: json['school_id'],
      lessonId: json['lesson_id'],
      teacherId: json['teacher_id'],
      startDate: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      endDate: json['end_date'] != null ? DateTime.parse(json['end_date']) : null,
      classroom: json['classroom'],
      deadline: json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
      price: json['price'] != null ? json['price'].toDouble() : null,
      quota: json['quota'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      lesson: json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null,
      teacher: json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'lesson_id': lessonId,
      'teacher_id': teacherId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'classroom': classroom,
      'deadline': deadline?.toIso8601String(),
      'price': price,
      'quota': quota,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt,
      'school': school?.toJson(),
      'lesson': lesson?.toJson(),
      'teacher': teacher?.toJson(),
    };
  }
}

class School {
  final int? id; // Changed to nullable
  final int? userId; // Changed to nullable
  final User? user; // Changed to nullable

  School({
    this.id,
    this.userId,
    this.user,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      userId: json['user_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int? id; // Changed to nullable
  final String? name; // Changed to nullable

  User({
    this.id,
    this.name,
  });

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

class Lesson {
  final int? id; // Changed to nullable
  final String? name; // Changed to nullable
  final String? color; // Changed to nullable

  Lesson({
    this.id,
    this.name,
    this.color,
  });

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
  final int? id; // Changed to nullable
  final int? userId; // Changed to nullable
  final User? user; // Changed to nullable

  Teacher({
    this.id,
    this.userId,
    this.user,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      userId: json['user_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user?.toJson(),
    };
  }
}
