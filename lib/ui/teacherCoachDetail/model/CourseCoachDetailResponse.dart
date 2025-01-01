class CourseCoachDetailResponse {
  final bool status;
  final CourseData data;

  CourseCoachDetailResponse({required this.status, required this.data});

  factory CourseCoachDetailResponse.fromJson(Map<String, dynamic> json) {
    return CourseCoachDetailResponse(
      status: json['status'],
      data: CourseData.fromJson(json['data']),
    );
  }
}

class CourseData {
  final String lesson;
  final String teacherName;
  final String teacherSurname;
  final int courseType;
  final School school;
  final Map<String, List<AvailableHour>> availableDates;

  CourseData({
    required this.lesson,
    required this.teacherName,
    required this.teacherSurname,
    required this.courseType,
    required this.school,
    required this.availableDates,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      lesson: json['lesson'],
      teacherName: json['teacher_name'],
      teacherSurname: json['teacher_surname'],
      courseType: json['course_type'],
      school: School.fromJson(json['school']),
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
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      cityName: json['city_name'],
      provinceName: json['province_name'],
    );
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
      id: json['id'],
      hour: json['hour'],
      classroom: json['classroom'],
      price: json['price'],
    );
  }
}
