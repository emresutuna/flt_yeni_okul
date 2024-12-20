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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    data['companyDesc'] = this.companyDesc;
    data['companyTitle'] = this.companyTitle;
    data['companyPhoto'] = this.companyPhoto;
    data['companyLocation'] = this.companyLocation;
    if (this.teacherList != null) {
      data['teacherList'] = this.teacherList!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['teacherName'] = this.teacherName;
    data['teacherSurname'] = this.teacherSurname;
    data['teacherBranch'] = this.teacherBranch;
    return data;
  }
}