import 'package:baykurs/ui/courseBundle/model/CourseBundleResponse.dart';

import '../../../util/DateExtension.dart';

class CourseBundleUiModel {
  int currentPage;
  List<CourseBundleListUiModel> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<LinksUiModel> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  CourseBundleUiModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CourseBundleUiModel.fromEntity(CourseBundle entity) {
    return CourseBundleUiModel(
      currentPage: entity.currentPage ?? 1,
      data: entity.data?.map((e) => CourseBundleListUiModel.fromEntity(e)).toList() ?? [],
      firstPageUrl: entity.firstPageUrl ?? "",
      from: entity.from ?? 0,
      lastPage: entity.lastPage ?? 0,
      lastPageUrl: entity.lastPageUrl ?? "",
      links: entity.links?.map((e) => LinksUiModel.fromEntity(e)).toList() ?? [],
      nextPageUrl: entity.nextPageUrl ?? "",
      path: entity.path ?? "",
      perPage: entity.perPage ?? 0,
      prevPageUrl: entity.prevPageUrl ?? "",
      to: entity.to ?? 0,
      total: entity.total ?? 0,
    );
  }
}

class CourseBundleListUiModel {
  String title;
  String description;
  DateTime startDate;
  String lessonName;
  String schoolName;
  int price;

  CourseBundleListUiModel({
    required this.title,
    required this.description,
    required this.startDate,
    required this.lessonName,
    required this.schoolName,
    required this.price,
  });

  factory CourseBundleListUiModel.fromEntity(CourseBundleList entity) {
    return CourseBundleListUiModel(
      title: entity.title ?? "Unknown Title",
      description: entity.description ?? "No Description",
      startDate: DateTime.parse(entity.startDate ?? "1970-01-01T00:00:00Z"),
      lessonName: entity.lessonName ?? "Unknown Lesson",
      schoolName: entity.schoolName ?? "Unknown School",
      price: entity.price ?? 0,
    );
  }

  String get formattedStartDate => formatStartDate(startDate);
}
class LinksUiModel {
  String url;
  String label;
  bool active;

  LinksUiModel({
    required this.url,
    required this.label,
    required this.active,
  });

  factory LinksUiModel.fromEntity(Links entity) {
    return LinksUiModel(
      url: entity.url ?? "",
      label: entity.label ?? "Unknown Label",
      active: entity.active ?? false,
    );
  }
}
