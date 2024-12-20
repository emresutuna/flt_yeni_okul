class FavoriteSchoolResponse {
  bool? status;
  List<SchoolList>? data;

  FavoriteSchoolResponse({this.status, this.data});

  FavoriteSchoolResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SchoolList>[];
      json['data'].forEach((v) {
        data!.add(SchoolList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchoolList {
  int? id;
  int? studentId;
  int? schoolId;
  String? createdAt;
  String? updatedAt;
  School? school;

  SchoolList(
      {this.id,
      this.studentId,
      this.schoolId,
      this.createdAt,
      this.updatedAt,
      this.school});

  SchoolList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    schoolId = json['school_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    school =
        json['school'] != null ? School.fromJson(json['school']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['school_id'] = this.schoolId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    return data;
  }
}

class School {
  int? id;
  int? userId;
  int? cityId;
  String? address;
  String? description;
  String? photo;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  bool? isFav;
  User? user;

  School(
      {this.id,
      this.userId,
      this.cityId,
      this.address,
      this.description,
      this.photo,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isFav,
      this.user});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    address = json['address'];
    description = json['description'];
    photo = json['photo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isFav = json['isFav'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['isFav'] = this.isFav;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? name;
  Null? surname;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  User(
      {this.id,
      this.roleId,
      this.name,
      this.surname,
      this.email,
      this.phone,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
