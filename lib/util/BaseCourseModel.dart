import 'DateExtension.dart';


class BaseCourse {
  int? id;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  num? price;
  int? quota;
  String? schoolName;
  String? classroom;
  School? school;
  String? lessonName;
  Lesson? lesson;
  List<Topics>? topics;
  int? courseType;

  /// Öğretmen bilgisi
  Teacher? teacher;
  String? teacherName;
  String? teacherSurname;

  /// Formatlanmış alanlar
  String? teacherFormatted;
  String? formattedLesson;
  String? formattedSchool;

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
    this.courseType,
    this.teacher,
    this.teacherName,
    this.teacherSurname,
  }) {
    teacherFormatted = _getFormattedTeacherName();
    formattedLesson = _getFormattedLesson();
    formattedSchool = _getFormattedSchool();
  }

  /// JSON'dan oluşturucu
  BaseCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    price = json['price'];
    quota = json['quota'];
    courseType = json['course_type'];
    classroom = json['classroom'];

    if (json['school'] != null) {
      if (json['school'] is Map<String, dynamic>) {
        school = School.fromJson(json['school']);
      } else if (json['school'] is String) {
        schoolName = json['school'];
      }
    }
    if (json['school_name'] is String) {
      schoolName = json['school_name'];
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
      teacher = Teacher.fromJson(json['teacher']);
    }
    teacherName = json['teacher_name'];
    teacherSurname = json['teacher_surname'];

    teacherFormatted = _getFormattedTeacherName();
    formattedLesson = _getFormattedLesson();
    formattedSchool = _getFormattedSchool();
  }

  /// JSON'a dönüştürücü
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'start_date': startDate,
    'end_date': endDate,
    'price': price,
    'quota': quota,
    'classroom': classroom,
    'course_type': courseType,
    'school': school?.toJson() ?? schoolName,
    'lesson': lesson?.toJson() ?? lessonName,
    'topics': topics?.map((topic) => topic.toJson()).toList(),
    'teacher_formatted': teacherFormatted,
    'formatted_lesson': formattedLesson,
    'formatted_school': formattedSchool,
  };

  /// Öğretmen adını formatlayan yardımcı fonksiyon
  String _getFormattedTeacherName() {
    print('Teacher: $teacher');
    print('Teacher user: ${teacher?.user}');
    print('Teacher user name: ${teacher?.user?.name}');
    print('Teacher user surname: ${teacher?.user?.surname}');

    final user = teacher?.user;

    // 1. Öncelikli kontrol: user varsa ve name boş değilse
    if (user != null && user.name != null && user.name!.isNotEmpty) {
      final name = user.name!;
      final surname = user.surname != null && user.surname!.isNotEmpty
          ? user.surname!
          : '';

      return '$name $surname'.trim(); // Eğer surname boşsa boşluk olmaz
    }

    // 2. İkinci kontrol: fallback teacherName ve teacherSurname
    if (teacherName != null && teacherSurname != null) {
      return "$teacherName $teacherSurname";
    }

    // 3. Hiçbiri yoksa default mesaj
    return "Öğretmen bilgisi mevcut değil";
  }



  /// Ders bilgisini formatlayan yardımcı fonksiyon
  String _getFormattedLesson() {
    if (lesson != null) {
      return "${lesson!.name} - ${lesson!.color}";
    } else if (lessonName != null) {
      return lessonName!;
    } else {
      return "Ders bilgisi mevcut değil";
    }
  }

  /// Okul bilgisini formatlayan yardımcı fonksiyon
  String _getFormattedSchool() {
    final schoolNameFromModel = school?.name;
    final schoolNameFromUser = school?.user?.name;

    if (schoolNameFromModel != null && schoolNameFromModel.isNotEmpty) {
      return schoolNameFromModel;
    } else if (schoolNameFromUser != null && schoolNameFromUser.isNotEmpty) {
      return schoolNameFromUser;
    } else if (schoolName != null && schoolName!.isNotEmpty) {
      return schoolName!;
    } else {
      return "Okul bilgisi mevcut değil";
    }
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
  User? user;

  School({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.cityName,
    this.provinceName,
    this.user,
  });

  // ✅ FROM JSON
  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    cityName = json['city_name'];
    provinceName = json['province_name'];

    // ✅ user parse etme kısmı eklendi
    if (json['user'] != null && json['user'] is Map<String, dynamic>) {
      user = User.fromJson(json['user']);
    }
  }

  // ✅ TO JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city_name'] = cityName;
    data['province_name'] = provinceName;
    if (user != null) {
      data['user'] = user!.toJson();
    }

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
  int? id;
  String? name;
  String? surname; // Opsiyonel çünkü JSON'da olmayabilir

  User({
    this.id,
    this.name,
    this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      surname: json['surname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
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
