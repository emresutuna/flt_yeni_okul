class MobileHomeResponse {
  bool? status;
  List<String>? sliderData;
  List<IncomingLesson>? incomingLesson;
  List<dynamic>? interestedLesson;

  MobileHomeResponse({
    this.status,
    this.sliderData,
    this.incomingLesson,
    this.interestedLesson,
  });

  factory MobileHomeResponse.fromJson(Map<String, dynamic> json) {
    return MobileHomeResponse(
      status: json['status'],
      sliderData: json['sliderData']?.cast<String>(),
      incomingLesson: json['incomingLesson'] != null
          ? (json['incomingLesson'] as List)
          .map((v) => IncomingLesson.fromJson(v))
          .toList()
          : null,
      interestedLesson: json['interestedLesson'] != null
          ? json['interestedLesson']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'sliderData': sliderData,
      'incomingLesson': incomingLesson?.map((v) => v.toJson()).toList(),
      'interestedLesson': interestedLesson,
    };
  }
}

class IncomingLesson {
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
  School? school;
  User? lesson;
  School? teacher;
  List<Topics>? topics;

  IncomingLesson({
    this.id,
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
    this.school,
    this.lesson,
    this.teacher,
    this.topics,
  });

  factory IncomingLesson.fromJson(Map<String, dynamic> json) {
    return IncomingLesson(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      schoolId: json['school_id'],
      lessonId: json['lesson_id'],
      teacherId: json['teacher_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      classroom: json['classroom'],
      deadline: json['deadline'],
      price: json['price'],
      quota: json['quota'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      lesson: json['lesson'] != null ? User.fromJson(json['lesson']) : null,
      teacher: json['teacher'] != null ? School.fromJson(json['teacher']) : null,
      topics: json['topics'] != null
          ? (json['topics'] as List).map((v) => Topics.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'school_id': schoolId,
      'lesson_id': lessonId,
      'teacher_id': teacherId,
      'start_date': startDate,
      'end_date': endDate,
      'classroom': classroom,
      'deadline': deadline,
      'price': price,
      'quota': quota,
      'school': school?.toJson(),
      'lesson': lesson?.toJson(),
      'teacher': teacher?.toJson(),
      'topics': topics?.map((v) => v.toJson()).toList(),
    };
  }
}

class School {
  int? id;
  int? userId;
  User? user;

  School({this.id, this.userId, this.user});

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
  int? id;
  String? name;

  User({this.id, this.name});

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

class Topics {
  int? id;
  String? name;
  Pivot? pivot;

  Topics({this.id, this.name, this.pivot});

  factory Topics.fromJson(Map<String, dynamic> json) {
    return Topics(
      id: json['id'],
      name: json['name'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pivot': pivot?.toJson(),
    };
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
