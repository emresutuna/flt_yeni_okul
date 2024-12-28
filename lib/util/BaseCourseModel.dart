import 'DateExtension.dart';

class BaseCourse {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? price;
  int? quota;
  String? schoolName;
  String? classroom;
  School? school;
  String? lessonName;
  Lesson? lesson;
  List<Topics>? topics;
  String? teacherFormatted;

  /// Lazy-loaded formatted start date
  String? get formattedStartDate =>
      startDate != null ? formatStartDate(DateTime.parse(startDate!)) : null;

  /// Lazy-loaded formatted end date
  String? get formattedEndDate =>
      endDate != null ? formatEndDate(DateTime.parse(endDate!)) : null;

  /// Lazy-loaded formatted date range
  String? get formattedDateRange => startDate != null && endDate != null
      ? formatDateRange(DateTime.parse(startDate!), DateTime.parse(endDate!))
      : null;

  BaseCourse({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.price,
    this.quota,
    this.schoolName,
    this.classroom,
    this.school,
    this.lessonName,
    this.lesson,
    this.topics,
    String? teacherName,
    String? teacherSurname,
    Teacher? teacher,
  }) {
    if (teacher != null) {
      teacherFormatted = teacher.user.name;
    } else if (teacherName != null && teacherSurname != null) {
      teacherFormatted = "$teacherName $teacherSurname";
    } else {
      teacherFormatted = "Öğretmen bilgisi mevcut değil";
    }
  }

  BaseCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    quota = json['quota'];
    classroom = json['classroom'];

    if (json['school'] != null) {
      if (json['school'] is Map<String, dynamic>) {
        school = School.fromJson(json['school']);
      } else if (json['school'] is String) {
        schoolName = json['school'];
      }
    }

    if (json['lesson'] != null) {
      if (json['lesson'] is Map<String, dynamic>) {
        lesson = Lesson.fromJson(json['lesson']);
      } else if (json['lesson'] is String) {
        lessonName = json['lesson'];
      }
    }
    if (json['lesson_name'] != null && json['lesson_name'] is String) {
      lessonName = json['lesson_name'];
    }

    if (json['topics'] != null && json['topics'] is List) {
      topics = (json['topics'] as List)
          .where((topic) => topic is Map<String, dynamic>)
          .map((topic) => Topics.fromJson(topic))
          .toList();
    }

    // Teacher kontrolü
    if (json['teacher'] != null && json['teacher'] is Map<String, dynamic>) {
      Teacher teacher = Teacher.fromJson(json['teacher']);
      teacherFormatted = teacher.user.name;
    } else if (json['teacher_name'] != null &&
        json['teacher_surname'] != null) {
      teacherFormatted = "${json['teacher_name']} ${json['teacher_surname']}";
    } else {
      teacherFormatted = "Öğretmen bilgisi mevcut değil";
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'start_date': startDate,
        'end_date': endDate,
        'price': price,
        'quota': quota,
        'classroom': classroom,
        'school': school?.toJson() ?? schoolName,
        'lesson': lesson?.toJson() ?? lessonName,
        'topics': topics?.map((topic) => topic.toJson()).toList(),
        'teacher_formatted': teacherFormatted,
      };
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

class Lesson {
  final int id;
  final String name;
  final String color;

  Lesson({required this.id, required this.name, required this.color});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

class Teacher {
  final int id;
  final int userId;
  final User user;

  Teacher({required this.id, required this.userId, required this.user});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
