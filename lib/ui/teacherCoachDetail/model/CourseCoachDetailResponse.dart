class CourseCoachDetailResponse {
  bool? status;
  CourseCoachDetail? data;

  CourseCoachDetailResponse({this.status, this.data});

  CourseCoachDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? CourseCoachDetail.fromJson(json['data']) : null;
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

class CourseCoachDetail {
  int? id;
  int? price;
  Course? course;
  String? title;
  String? description;

  CourseCoachDetail(
      {this.id, this.price, this.course, this.title, this.description});

  CourseCoachDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class Topics {
  int? id;
  String? name;

  Topics({this.id, this.name});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Course {
  int? id;
  String? startDate;
  String? endDate;
  String? classroom;
  int? quota;
  List<Topics>? topics;
  School? school;
  String? lesson;
  String? teacherName;
  String? teacherSurname;

  Course(
      {this.id,
      this.startDate,
      this.endDate,
      this.classroom,
      this.quota,
      this.topics,
      this.school,
      this.lesson,
      this.teacherName,
      this.teacherSurname});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    classroom = json['classroom'];
    quota = json['quota'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    lesson = json['lesson'];
    teacherName = json['teacher_name'];
    teacherSurname = json['teacher_surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['classroom'] = classroom;
    data['quota'] = quota;
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (school != null) {
      data['school'] = school!.toJson();
    }
    data['lesson'] = lesson;
    data['teacher_name'] = teacherName;
    data['teacher_surname'] = teacherSurname;
    return data;
  }
}

class School {
  int? id;
  String? name;
  String? address;
  String? latitude;
  String? longitude;
  String? cityName;
  String? provinceName;

  School(
      {this.id,
      this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.cityName,
      this.provinceName});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cityName = json['city_name'];
    provinceName = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city_name'] = cityName;
    data['province_name'] = provinceName;
    return data;
  }
}
