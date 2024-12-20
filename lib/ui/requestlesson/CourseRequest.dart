class CourseRequest {
  int topicId;
  int cityId;
  int schoolId;
  String subject;

  CourseRequest({
    required this.topicId,
    required this.cityId,
    required this.schoolId,
    required this.subject,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic_id': topicId,
      'city_id': cityId,
      'school_id': schoolId,
      'subject': subject,
    };
  }

  factory CourseRequest.fromJson(Map<String, dynamic> json) {
    return CourseRequest(
      topicId: json['lesson_id'],
      cityId: json['city_id'],
      schoolId: json['school_id'],
      subject: json['subject'],
    );
  }
}
