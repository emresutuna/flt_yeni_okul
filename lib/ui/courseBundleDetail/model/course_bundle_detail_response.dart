import '../../../util/BaseCourseModel.dart';

class CourseBundleDetailResponse {
  final bool status;
  final CourseBundleData data;

  CourseBundleDetailResponse({
    required this.status,
    required this.data,
  });

  factory CourseBundleDetailResponse.fromJson(Map<String, dynamic> json) {
    return CourseBundleDetailResponse(
      status: json['status'] ?? false,
      data: CourseBundleData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
    };
  }
}

class CourseBundleData {
  final int id;
  final String title;
  final String description;
  final double price;
  final List<BaseCourse> courses;

  CourseBundleData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.courses,
  });

  factory CourseBundleData.fromJson(Map<String, dynamic> json) {
    return CourseBundleData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      courses: (json['courses'] as List<dynamic>)
          .map((e) => BaseCourse.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'courses': courses.map((course) => course.toJson()).toList(),
    };
  }
}
