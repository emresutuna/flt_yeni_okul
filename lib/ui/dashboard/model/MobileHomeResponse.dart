import '../../../util/BaseCourseModel.dart';

class MobileHomeResponse {
  bool? status;
  List<SliderData>? sliderData;
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
      interestedLesson:
          json['interestedLesson'] != null ? json['interestedLesson'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'sliderData': sliderData?.map((v) => v.toJson()).toList(),
      'incomingLesson': incomingLesson?.map((v) => v.toJson()).toList(),
      'interestedLesson': interestedLesson,
    };
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['img'] = this.img;
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
  int? price;
  int? quota;
  int? courseType;
  School? school;
  User? lesson;
  List<Topics>? topics;

  IncomingLesson(
      {this.id,
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
        this.topics});

  IncomingLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    schoolId = json['school_id'];
    lessonId = json['lesson_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    quota = json['quota'];
    courseType = json['course_type'];
    school =
    json['school'] != null ? new School.fromJson(json['school']) : null;
    lesson = json['lesson'] != null ? new User.fromJson(json['lesson']) : null;
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['school_id'] = this.schoolId;
    data['lesson_id'] = this.lessonId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['price'] = this.price;
    data['quota'] = this.quota;
    data['course_type'] = this.courseType;
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    if (this.lesson != null) {
      data['lesson'] = this.lesson!.toJson();
    }
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
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
