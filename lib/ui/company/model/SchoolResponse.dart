class SchoolResponse {
  final bool status;
  final SchoolData data;

  SchoolResponse({required this.status, required this.data});

  factory SchoolResponse.fromJson(Map<String, dynamic> json) {
    return SchoolResponse(
      status: json['status'],
      data: SchoolData.fromJson(json['data']),
    );
  }

  // CopyWith for SchoolResponse
  SchoolResponse copyWith({
    bool? status,
    SchoolData? data,
  }) {
    return SchoolResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

class SchoolData {
  final int currentPage;
  final List<SchoolItem> schools;
  final String? firstPageUrl;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? prevPageUrl;
  final int total;

  SchoolData({
    required this.currentPage,
    required this.schools,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    required this.total,
  });

  factory SchoolData.fromJson(Map<String, dynamic> json) {
    return SchoolData(
      currentPage: json['current_page'],
      schools: (json['data'] as List)
          .map((item) => SchoolItem.fromJson(item))
          .toList(),
      firstPageUrl: json['first_page_url'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
      total: json['total'],
    );
  }

  // CopyWith for SchoolData
  SchoolData copyWith({
    int? currentPage,
    List<SchoolItem>? schools,
    String? firstPageUrl,
    String? lastPageUrl,
    String? nextPageUrl,
    String? prevPageUrl,
    int? total,
  }) {
    return SchoolData(
      currentPage: currentPage ?? this.currentPage,
      schools: schools ?? this.schools,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      total: total ?? this.total,
    );
  }
}

class SchoolItem {
  final int id;
  final int userId;
  final int cityId;
  final String address;
  final String description;
  final String? photo;
  bool isFav;
  final City city;
  final User user;

  SchoolItem({
    required this.id,
    required this.userId,
    required this.cityId,
    required this.address,
    required this.description,
    required this.photo,
    required this.isFav,
    required this.city,
    required this.user,
  });

  factory SchoolItem.fromJson(Map<String, dynamic> json) {
    return SchoolItem(
      id: json['id'],
      userId: json['user_id'],
      cityId: json['city_id'],
      address: json['address'],
      description: json['description'],
      photo: json['photo'],
      isFav: json['isFav'],
      city: City.fromJson(json['city']),
      user: User.fromJson(json['user']),
    );
  }

  // CopyWith for SchoolItem
  SchoolItem copyWith({
    int? id,
    int? userId,
    int? cityId,
    String? address,
    String? description,
    String? photo,
    bool? isFav,
    City? city,
    User? user,
  }) {
    return SchoolItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cityId: cityId ?? this.cityId,
      address: address ?? this.address,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      isFav: isFav ?? this.isFav,
      city: city ?? this.city,
      user: user ?? this.user,
    );
  }
}

class City {
  final int id;
  final String name;
  final int provinceId;
  final Province province;

  City({
    required this.id,
    required this.name,
    required this.provinceId,
    required this.province,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      provinceId: json['province_id'],
      province: Province.fromJson(json['province']),
    );
  }

  // CopyWith for City
  City copyWith({
    int? id,
    String? name,
    int? provinceId,
    Province? province,
  }) {
    return City(
      id: id ?? this.id,
      name: name ?? this.name,
      provinceId: provinceId ?? this.provinceId,
      province: province ?? this.province,
    );
  }
}

class Province {
  final int id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
    );
  }

  // CopyWith for Province
  Province copyWith({
    int? id,
    String? name,
  }) {
    return Province(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // CopyWith for User
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
