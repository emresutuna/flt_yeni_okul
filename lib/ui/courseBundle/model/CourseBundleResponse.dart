import '../../../util/BaseCourseModel.dart';
import '../../course/model/CourseModel.dart';

class CourseBundleResponse {
  bool? status;
  CourseBundleData? data;

  CourseBundleResponse({this.status, this.data});

  CourseBundleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? CourseBundleData.fromJson(json['data']) : null;
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

class CourseBundleData {
  int? currentPage;
  List<CourseBundle>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  CourseBundleData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  CourseBundleData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CourseBundle>[];
      json['data'].forEach((v) {
        data!.add(CourseBundle.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class CourseBundle extends BaseCourse {
  CourseBundle({
    int? id,
    String? title,
    String? description,
    String? startDate,
    String? endDate,
    int? price,
    int? quota,
    String? schoolName,
    School? school,
    String? lessonName,
    Lesson? lesson,
  }) : super(
    id: id,
    title: title,
    description: description,
    startDate: startDate,
    endDate: endDate,
    price: price,
    quota: quota,
    schoolName: schoolName,
    school: school,
    lessonName: lessonName,
    lesson: lesson,
  );

  CourseBundle.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
  CourseList toCourseList() {
    return CourseList(
      id: id,
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      price: price,
      quota: quota,
      schoolName: schoolName,
      school: school,
      topics: topics,
      lessonName: lessonName,
    );
  }
}