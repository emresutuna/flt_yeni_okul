class SchoolResponse {
  bool? status;
  PageData? data;

  SchoolResponse({this.status, this.data});

  SchoolResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new PageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PageData {
  List<School>? data;
  String? path;
  int? perPage;
  int? nextCursor;
  int? nextPageUrl;
  int? prevCursor;
  int? prevPageUrl;

  PageData(
      {this.data,
        this.path,
        this.perPage,
        this.nextCursor,
        this.nextPageUrl,
        this.prevCursor,
        this.prevPageUrl});

  PageData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <School>[];
      json['data'].forEach((v) {
        data!.add(new School.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    nextCursor = json['next_cursor'];
    nextPageUrl = json['next_page_url'];
    prevCursor = json['prev_cursor'];
    prevPageUrl = json['prev_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['next_cursor'] = this.nextCursor;
    data['next_page_url'] = this.nextPageUrl;
    data['prev_cursor'] = this.prevCursor;
    data['prev_page_url'] = this.prevPageUrl;
    return data;
  }
}

class School {
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

  School(
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
        this.photo});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['province_id'] = this.provinceId;
    data['city_id'] = this.cityId;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['photo'] = this.photo;
    return data;
  }
}

class User {
  int? id;
  int? roleId;
  String? name;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  User(
      {this.id,
        this.roleId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['order'] = this.order;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['province_id'] = this.provinceId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['order'] = this.order;
    return data;
  }
}