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
class IncomingLesson extends BaseCourse {
  int? schoolId;
  int? lessonId;
  int? teacherId;
  String? classroom;
  String? deadline;
  School? school;
  Lesson? lesson;
  Teacher? teacher;
  List<Topics>? topics;

  IncomingLesson(
      {int? id,
      String? title,
      String? description,
      String? startDate,
      String? endDate,
      int? price,
      int? quota,
      this.schoolId,
      this.lessonId,
      this.teacherId,
      this.classroom,
      this.deadline,
      this.school,
      this.lesson,
      this.teacher,
      this.topics})
      : super(
            id: id,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            price: price,
            quota: quota);

  IncomingLesson.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    schoolId = json['school_id'];
    lessonId = json['lesson_id'];
    teacherId = json['teacher_id'];
    classroom = json['classroom'];
    deadline = json['deadline'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    lesson = json['lesson'] != null ? Lesson.fromJson(json['lesson']) : null;
    teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    topics = json['topics'] != null
        ? (json['topics'] as List).map((v) => Topics.fromJson(v)).toList()
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['school_id'] = schoolId;
    data['lesson_id'] = lessonId;
    data['teacher_id'] = teacherId;
    data['classroom'] = classroom;
    data['deadline'] = deadline;
    data['school'] = school?.toJson();
    data['lesson'] = lesson?.toJson();
    data['teacher'] = teacher?.toJson();
    data['topics'] = topics?.map((v) => v.toJson()).toList();
    return data;
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
