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
    final Map<String, dynamic> data = {};
    data['status'] = status;
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
  School? school;

  SchoolList({
    this.id,
    this.studentId,
    this.schoolId,
    this.school,
  });

  SchoolList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    schoolId = json['school_id'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['student_id'] = studentId;
    data['school_id'] = schoolId;
    if (school != null) {
      data['school'] = school!.toJson();
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
  bool? isFav;
  User? user;
  City? city;

  School({
    this.id,
    this.userId,
    this.cityId,
    this.address,
    this.description,
    this.photo,
    this.isFav,
    this.user,
    this.city,
  });

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    address = json['address'];
    description = json['description'];
    photo = json['photo'];
    isFav = json['isFav'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['city_id'] = cityId;
    data['address'] = address;
    data['description'] = description;
    data['photo'] = photo;
    data['isFav'] = isFav;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? name;
  String? surname; // Null olabilir
  String? email;
  String? phone;

  User({
    this.id,
    this.roleId,
    this.name,
    this.surname,
    this.email,
    this.phone,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['role_id'] = roleId;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
class City {
  int? id;
  String? name;
  int? provinceId;
  Province? province;

  City({
    this.id,
    this.name,
    this.provinceId,
    this.province,
  });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    province = json['province'] != null
        ? Province.fromJson(json['province'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['province_id'] = provinceId;
    if (province != null) {
      data['province'] = province!.toJson();
    }
    return data;
  }
}
class Province {
  int? id;
  String? name;

  Province({
    this.id,
    this.name,
  });

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

