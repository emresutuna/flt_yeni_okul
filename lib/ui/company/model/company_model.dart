class CompanyModel {
  int? id;
  int? companyId;
  String? companyName;
  String? companyDesc;
  String? companyTitle;
  String? companyPhoto;
  List<double>? companyLocation;
  List<Teacher>? teacherList;

  CompanyModel(
      {this.id,
        this.companyId,
        this.companyName,
        this.companyDesc,
        this.companyTitle,
        this.companyPhoto,
        this.companyLocation,
        this.teacherList});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    companyDesc = json['companyDesc'];
    companyTitle = json['companyTitle'];
    companyPhoto = json['companyPhoto'];
    companyLocation = json['companyLocation'].cast<double>();
    if (json['teacherList'] != null) {
      teacherList = <Teacher>[];
      json['teacherList'].forEach((v) {
        teacherList!.add(Teacher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['companyDesc'] = companyDesc;
    data['companyTitle'] = companyTitle;
    data['companyPhoto'] = companyPhoto;
    data['companyLocation'] = companyLocation;
    if (teacherList != null) {
      data['teacherList'] = teacherList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teacher {
  int? id;
  String? teacherName;
  String? teacherSurname;
  String? teacherBranch;

  Teacher(
      {this.id, this.teacherName, this.teacherSurname, this.teacherBranch});

  Teacher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teacherName = json['teacherName'];
    teacherSurname = json['teacherSurname'];
    teacherBranch = json['teacherBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacherName'] = teacherName;
    data['teacherSurname'] = teacherSurname;
    data['teacherBranch'] = teacherBranch;
    return data;
  }
}