class EducationInformationResponse {
  bool? success;
  EducationInfo? educationInfo;

  EducationInformationResponse({this.success, this.educationInfo});

  EducationInformationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    educationInfo = json['data'] != null
        ? EducationInfo.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (educationInfo != null) {
      data['data'] = educationInfo!.toJson();
    }
    return data;
  }
}

class EducationInfo {
  String? schoolName;
  String? schoolAddress;
  String? grade;

  EducationInfo({this.schoolName, this.schoolAddress, this.grade});

  EducationInfo.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    schoolAddress = json['schoolAddress'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolName'] = schoolName;
    data['schoolAddress'] = schoolAddress;
    data['grade'] = grade;
    return data;
  }
}
