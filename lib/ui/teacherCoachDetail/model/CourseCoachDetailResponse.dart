class CourseCoachDetailResponse {
  final bool status;
  final CourseData data;

  CourseCoachDetailResponse({required this.status, required this.data});

  factory CourseCoachDetailResponse.fromJson(Map<String, dynamic> json) {
    return CourseCoachDetailResponse(
      status: json['status'] ?? false,
      data: CourseData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class CourseData {
  final String title;
  final String description;
  final int quota;
  final String lesson;
  final String teacherName;
  final String teacherSurname;
  final int courseType;
  final School school;
  final Map<String, List<AvailableHour>> availableDates;

  CourseData({
    required this.title,
    required this.description,
    required this.quota,
    required this.lesson,
    required this.teacherName,
    required this.teacherSurname,
    required this.courseType,
    required this.school,
    required this.availableDates,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      title: json['title'] ?? "Başlık mevcut değil",
      description: json['description'] ?? "Açıklama mevcut değil",
      quota: json['quota'] ?? 0,
      lesson: json['lesson'] ?? "Ders bilgisi mevcut değil",
      teacherName: json['teacher_name'] ?? "Öğretmen adı mevcut değil",
      teacherSurname: json['teacher_surname'] ?? "Öğretmen soyadı mevcut değil",
      courseType: json['course_type'] ?? 0,
      school: School.fromJson(json['school'] ?? {}),
      availableDates: (json['availableDates'] as Map<String, dynamic>).map(
            (date, hours) => MapEntry(
          date,
          (hours['availableHours'] as List)
              .map((hour) => AvailableHour.fromJson(hour))
              .toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'quota': quota,
      'lesson': lesson,
      'teacher_name': teacherName,
      'teacher_surname': teacherSurname,
      'course_type': courseType,
      'school': school.toJson(),
      'availableDates': availableDates.map((key, value) => MapEntry(
          key, value.map((hour) => hour.toJson()).toList())),
    };
  }
}

class School {
  final int id;
  final String name;
  final String address;
  final String latitude;
  final String longitude;
  final String cityName;
  final String provinceName;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.provinceName,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Okul adı mevcut değil",
      address: json['address'] ?? "Adres mevcut değil",
      latitude: json['latitude'] ?? "0.0",
      longitude: json['longitude'] ?? "0.0",
      cityName: json['city_name'] ?? "Şehir bilgisi mevcut değil",
      provinceName: json['province_name'] ?? "İl bilgisi mevcut değil",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'city_name': cityName,
      'province_name': provinceName,
    };
  }
}

class AvailableHour {
  final int id;
  final String hour;
  final String classroom;
  final int price;

  AvailableHour({
    required this.id,
    required this.hour,
    required this.classroom,
    required this.price,
  });

  factory AvailableHour.fromJson(Map<String, dynamic> json) {
    return AvailableHour(
      id: json['id'] ?? 0,
      hour: json['hour'] ?? "Saat bilgisi mevcut değil",
      classroom: json['classroom'] ?? "Sınıf bilgisi mevcut değil",
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': hour,
      'classroom': classroom,
      'price': price,
    };
  }
}
