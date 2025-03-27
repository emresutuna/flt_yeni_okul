class MobileHomeResponse {
  bool? status;
  List<SliderData>? sliderData;
  List<IncomingLesson>? incomingLesson;
  List<InterestedLesson>? interestedLesson;
  Notifications? notifications;

  MobileHomeResponse(
      {this.status,
      this.sliderData,
      this.incomingLesson,
      this.interestedLesson,
      this.notifications});

  factory MobileHomeResponse.fromJson(Map<String, dynamic> json) {
    return MobileHomeResponse(
      status: json['status'],
      notifications: json['notifications'] != null
          ? Notifications.fromJson(json['notifications'])
          : null,
      sliderData: json['sliderData'] != null
          ? (json['sliderData'] as List)
              .map((v) => SliderData.fromJson(v))
              .toList()
          : null,
      incomingLesson: json['incomingLesson'] != null
          ? (json['incomingLesson'] as List)
              .map((v) => IncomingLesson.fromJson(v))
              .toList()
          : null,
      interestedLesson: json['interestedLesson'] != null
          ? (json['interestedLesson'] as List)
          .map((v) => InterestedLesson.fromJson(v))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'notifications': notifications!.toJson(),
      'sliderData': sliderData?.map((v) => v.toJson()).toList(),
      'incomingLesson': incomingLesson?.map((v) => v.toJson()).toList(),
      'interestedLesson': interestedLesson?.map((v) => v.toJson()).toList(),
    };
  }
}

class Notifications {
  bool? exists;
  int? count;

  Notifications({this.exists, this.count});

  Notifications.fromJson(Map<String, dynamic> json) {
    exists = json['exists'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exists'] = exists;
    data['count'] = count;
    return data;
  }
}

class SliderData {
  int? id;
  String? title;
  String? description;
  String? img;

  SliderData({this.id, this.title, this.description, this.img});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['img'] = img;
    return data;
  }
}

class IncomingLesson {
  int? id;
  String? title;
  String? description;
  int? schoolId;
  int? lessonId;
  String? startDate;
  String? endDate;
  num? price;
  int? quota;
  int? courseType;
  School? school;
  User? lesson;
  List<Topics>? topics;
  Teacher? teacher;
  String? attendanceUrl;
  bool? isAttendanceCompleted;
  int? courseBundleId;
  int? courseCoachId;

  IncomingLesson({
    this.id,
    this.title,
    this.description,
    this.schoolId,
    this.lessonId,
    this.startDate,
    this.endDate,
    this.price,
    this.quota,
    this.courseType,
    this.school,
    this.lesson,
    this.topics,
    this.teacher,
    this.attendanceUrl,
    this.isAttendanceCompleted,
    this.courseBundleId,
    this.courseCoachId
  });

  IncomingLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    schoolId = json['school_id'];
    lessonId = json['lesson_id'];
    startDate = json['start_date'];
    attendanceUrl = json['attendance_url'];
    isAttendanceCompleted = json['is_attendance_completed'];
    endDate = json['end_date'];
    price = json['price'];
    quota = json['quota'];
    courseType = json['course_type'];
    courseBundleId = json['course_bundle_id'];
    courseCoachId = json['course_coach_id'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    lesson = json['lesson'] != null ? User.fromJson(json['lesson']) : null;

    // topics
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }

    // teacher
    teacher = json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['school_id'] = schoolId;
    data['lesson_id'] = lessonId;
    data['start_date'] = startDate;
    data['attendance_url'] = attendanceUrl;
    data['is_attendance_completed'] = isAttendanceCompleted;
    data['end_date'] = endDate;
    data['price'] = price;
    data['quota'] = quota;
    data['course_type'] = courseType;
    data['course_bundle_id'] = courseBundleId;
    data['course_coach_id'] = courseCoachId;

    if (school != null) {
      data['school'] = school!.toJson();
    }

    if (lesson != null) {
      data['lesson'] = lesson!.toJson();
    }

    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }

    if (teacher != null) {
      data['teacher'] = teacher!.toJson();
    }

    return data;
  }
}

class School {
  int? id;
  int? userId;
  User? user;

  School({this.id, this.userId, this.user});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
class Teacher {
  int? id;
  int? userId;
  TeacherUser? user;

  Teacher({this.id, this.userId, this.user});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? TeacherUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class TeacherUser {
  int? id;
  String? name;
  String? surname;

  TeacherUser({this.id, this.name, this.surname});

  TeacherUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
    };
  }
}


class Topics {
  int? id;
  String? name;
  Pivot? pivot;

  Topics({this.id, this.name, this.pivot});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? courseId;
  int? topicId;

  Pivot({this.courseId, this.topicId});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      courseId: json['course_id'],
      topicId: json['topic_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'topic_id': topicId,
    };
  }
}
class InterestedLesson {
  int? id;
  String? title;
  String? description;
  int? schoolId;
  int? lessonId;
  int? teacherId;
  String? startDate;
  String? endDate;
  String? classroom;
  String? deadline;
  int? price;
  int? quota;
  Null? courseBundleId;
  Null? courseCoachId;
  int? courseType;
  School? school;
  User? lesson;
  List<Topics>? topics;

  InterestedLesson(
      {this.id,
        this.title,
        this.description,
        this.schoolId,
        this.lessonId,
        this.teacherId,
        this.startDate,
        this.endDate,
        this.classroom,
        this.deadline,
        this.price,
        this.quota,
        this.courseBundleId,
        this.courseCoachId,
        this.courseType,
        this.school,
        this.lesson,
        this.topics});

  InterestedLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    schoolId = json['school_id'];
    lessonId = json['lesson_id'];
    teacherId = json['teacher_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    classroom = json['classroom'];
    deadline = json['deadline'];
    price = json['price'];
    quota = json['quota'];
    courseBundleId = json['course_bundle_id'];
    courseCoachId = json['course_coach_id'];
    courseType = json['course_type'];
    school =
    json['school'] != null ? School.fromJson(json['school']) : null;
    lesson = json['lesson'] != null ? User.fromJson(json['lesson']) : null;
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['school_id'] = schoolId;
    data['lesson_id'] = lessonId;
    data['teacher_id'] = teacherId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['classroom'] = classroom;
    data['deadline'] = deadline;
    data['price'] = price;
    data['quota'] = quota;
    data['course_bundle_id'] = courseBundleId;
    data['course_coach_id'] = courseCoachId;
    data['course_type'] = courseType;
    if (school != null) {
      data['school'] = school!.toJson();
    }
    if (lesson != null) {
      data['lesson'] = lesson!.toJson();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
