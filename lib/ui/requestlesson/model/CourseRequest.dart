class CourseRequest {
  int topicId;
  int cityId;
  int? schoolId;
  String subject;
  int courseType;

  CourseRequest({
    required this.topicId,
    required this.cityId,
    required this.schoolId,
    required this.subject,
    required this.courseType,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'topic_id': topicId,
      'city_id': cityId,
      'subject': subject,
      'course_type': courseType,
    };

    if (schoolId != null) {
      data['school_id'] = schoolId;
    }

    return data;
  }


  factory CourseRequest.fromJson(Map<String, dynamic> json) {
    return CourseRequest(
      topicId: json['lesson_id'],
      cityId: json['city_id'],
      schoolId: json['school_id'],
      subject: json['subject'],
      courseType: json['course_type'],
    );
  }
}
