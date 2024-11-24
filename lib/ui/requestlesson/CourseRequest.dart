class CourseRequest {
  String lessonId;
  String cityId;
  String schoolId;
  String name;
  String message;

  CourseRequest({
    required this.lessonId,
    required this.cityId,
    required this.schoolId,
    required this.name,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'lesson_id': lessonId,
      'city_id': cityId,
      'school_id': schoolId,
      'name': name,
      'message': message,
    };
  }

  factory CourseRequest.fromJson(Map<String, dynamic> json) {
    return CourseRequest(
      lessonId: json['lesson_id'],
      cityId: json['city_id'],
      schoolId: json['school_id'],
      name: json['name'],
      message: json['message'],
    );
  }
}
