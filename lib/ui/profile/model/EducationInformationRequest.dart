class EducationInformationRequest {
  String? schoolName;
  String? schoolAddress;
  String? grade;

  EducationInformationRequest(
      {this.schoolName, this.schoolAddress, this.grade});

  EducationInformationRequest.fromJson(Map<String, dynamic> json) {
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