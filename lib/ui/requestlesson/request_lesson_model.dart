 class RequestLessonModel {
   String lessonName;
   String subjectName;
   String areaName;
   String townName;
   String companyName;

  RequestLessonModel({
    this.lessonName = '',
    this.subjectName = '',
    this.areaName = '',
    this.townName = '',
    this.companyName = '',
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'lessonName': lessonName,
      'subjectName': subjectName,
      'areaName': areaName,
      'townName': townName,
      'companyName': companyName,
    };
  }

  // JSON deserialization
  factory RequestLessonModel.fromJson(Map<String, dynamic> json) {
    return RequestLessonModel(
      lessonName: json['lessonName'],
      subjectName: json['subjectName'],
      areaName: json['areaName'],
      townName: json['townName'],
      companyName: json['companyName'],
    );
  }

  @override
  String toString() {
    return 'Lesson(lessonName: $lessonName, subjectName: $subjectName, areaName: $areaName, townName: $townName, companyName: $companyName)';
  }
}
