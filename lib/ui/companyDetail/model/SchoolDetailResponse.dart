class SchoolDetailResponse {
  bool? status;
  SchoolDetail? data;

  SchoolDetailResponse({this.status, this.data});

  SchoolDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SchoolDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SchoolDetail {
  int? id;
  int? userId;
  int? provinceId;
  int? cityId;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  User? user;
  Province? province;
  City? city;
  String? photo;
  String? description;
  List<Teachers>? teachers;

  SchoolDetail(
      {this.id,
        this.userId,
        this.provinceId,
        this.cityId,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.user,
        this.province,
        this.city,
        this.photo,
        this.description,
        this.teachers});

  SchoolDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    province = json['province'] != null
        ? Province.fromJson(json['province'])
        : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    photo = json['photo'];
    description = json['description'];
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['province_id'] = provinceId;
    data['city_id'] = cityId;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (province != null) {
      data['province'] = province!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['photo'] = photo;
    if (teachers != null) {
      data['teachers'] = teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? name;
  String? tckn;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
        this.roleId,
        this.name,
        this.tckn,
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
    tckn = json['tckn'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_id'] = roleId;
    data['name'] = name;
    data['tckn'] = tckn;
    data['email'] = email;
    data['phone'] = phone;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Province {
  int? id;
  String? name;
  String? code;
  String? latitude;
  String? longitude;
  int? order;

  Province(
      {this.id,
        this.name,
        this.code,
        this.latitude,
        this.longitude,
        this.order});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['order'] = order;
    return data;
  }
}

class City {
  int? id;
  int? provinceId;
  String? name;
  String? latitude;
  String? longitude;
  int? order;

  City(
      {this.id,
        this.provinceId,
        this.name,
        this.latitude,
        this.longitude,
        this.order});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceId = json['province_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province_id'] = provinceId;
    data['name'] = name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['order'] = order;
    return data;
  }
}

class Teachers {
  int? id;
  int? userId;
  int? schoolId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Teachers(
      {this.id,
        this.userId,
        this.schoolId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Teachers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    schoolId = json['school_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['school_id'] = schoolId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}