import 'DateExtension.dart';

import 'DateExtension.dart';

class BaseCourse {
  int? id;
  String? title;
  String? description;
  String? startDate; // Orijinal başlangıç tarihi (String olarak tutulur)
  String? endDate; // Orijinal bitiş tarihi (String olarak tutulur)
  int? price;
  int? quota;
  String? schoolName; // School'un adı
  School? school; // School nesnesi
  String? lessonName; // Lesson'un adı
  Lesson? lesson; // Lesson nesnesi
  List<Topics>? topics;
  String? formattedStartDate;
  String? formattedEndDate;
  String? formattedDateRange;

  // Yeni eklenen alan
  String? teacherFormatted;

  BaseCourse({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.price,
    this.quota,
    this.schoolName,
    this.school,
    this.lessonName,
    this.lesson,
    this.topics,
    Teacher? teacher, // Teacher nesnesi eklendi
    String? teacherName, // teacher_name eklendi
    String? teacherSurname, // teacher_surname eklendi
  }) {
    if (startDate != null) {
      DateTime parsedStartDate = DateTime.parse(startDate!);
      formattedStartDate = formatStartDate(parsedStartDate);
    }

    if (endDate != null) {
      DateTime parsedEndDate = DateTime.parse(endDate!);
      formattedEndDate = formatEndDate(parsedEndDate);
    }

    if (startDate != null && endDate != null) {
      DateTime parsedStartDate = DateTime.parse(startDate!);
      DateTime parsedEndDate = DateTime.parse(endDate!);
      formattedDateRange = formatDateRange(parsedStartDate, parsedEndDate);
    }

    // teacherFormatted alanını ayarla
    if (teacher != null) {
      teacherFormatted = teacher.user.name; // Teacher nesnesindeki isim
    } else if (teacherName != null && teacherSurname != null) {
      teacherFormatted =
          "$teacherName $teacherSurname"; // teacher_name ve teacher_surname birleştirilir
    } else {
      teacherFormatted = ""; // Varsayılan değer
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

    school = json['school'] != null && json['school'] is Map<String, dynamic>
        ? School.fromJson(json['school'])
        : null;
    schoolName = json['school_name'] is String
        ? json['school_name']
        : json['school'] is String
            ? json['school']
            : null;
    lessonName = json['lesson_name'] is String
        ? json['lesson_name']
        : json['lesson'] is String
            ? json['lesson']
            : null;
    lesson = json['lesson'] != null && json['lesson'] is Map<String, dynamic>
        ? Lesson.fromJson(json['lesson'])
        : null;

    // Topics işlemleri
    if (json['topics'] is List) {
      topics = (json['topics'] as List)
          .map((topic) => Topics.fromJson(topic))
          .toList();
    }

    // Tarihlerin formatlanması
    if (startDate != null) {
      DateTime parsedStartDate = DateTime.parse(startDate!);
      formattedStartDate = formatStartDate(parsedStartDate);
    }

    if (endDate != null) {
      DateTime parsedEndDate = DateTime.parse(endDate!);
      formattedEndDate = formatEndDate(parsedEndDate);
    }

    if (startDate != null && endDate != null) {
      DateTime parsedStartDate = DateTime.parse(startDate!);
      DateTime parsedEndDate = DateTime.parse(endDate!);
      formattedDateRange = formatDateRange(parsedStartDate, parsedEndDate);
    }

    // teacherFormatted alanını ayarla
    Teacher? teacher =
        json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    String? teacherName = json['teacher_name'];
    String? teacherSurname = json['teacher_surname'];

    if (teacher != null) {
      teacherFormatted = teacher.user.name;
    } else if (teacherName != null && teacherSurname != null) {
      teacherFormatted = "$teacherName $teacherSurname";
    } else {
      teacherFormatted = "Öğretmen bilgisi bulunamadı";
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'start_date': startDate,
      'end_date': endDate,
      'price': price,
      'quota': quota,
      'school': school?.toJson() ?? schoolName,
      'lesson': lesson?.toJson() ?? lessonName,
      'topics': topics?.map((topic) => topic.toJson()).toList(),
      'formatted_start_date': formattedStartDate,
      'formatted_end_date': formattedEndDate,
      'formatted_date_range': formattedDateRange,
      'teacher_formatted': teacherFormatted, // Yeni eklenen alan
    };
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
