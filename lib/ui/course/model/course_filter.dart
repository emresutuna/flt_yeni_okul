class CourseFilter {
  final String? query;
  final String? cityName;
  final String? provinceName;
  final int? provinceId;
  final int? cityId;
  final int? lessonId;
  final int? topicId;
  final int? maxPrice;
  final int? minPrice;
  final int? schoolId;
  final String? currentPage;

  CourseFilter({
    this.query,
    this.cityName,
    this.provinceName,
    this.provinceId,
    this.cityId,
    this.lessonId,
    this.topicId,
    this.maxPrice,
    this.minPrice,
    this.schoolId,
    this.currentPage,
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};
    if (query != null && query!.isNotEmpty) params['title'] = query!;
    if (provinceId != null) params['city_id'] = provinceId.toString();
    if (cityId != null) params['province_id'] = cityId.toString();
    if (lessonId != null) params['lesson_id'] = lessonId.toString();
    if (topicId != null) params['topic_id'] = topicId.toString();
    if (minPrice != null) params['min_price'] = minPrice.toString();
    if (maxPrice != null) params['max_price'] = maxPrice.toString();
    if (schoolId != null) params['school_id'] = schoolId.toString();
    if (currentPage != null) params['page'] = currentPage.toString();
    return params;
  }

  CourseFilter copyWith(
      {String? query,
      String? cityName,
      String? provinceName,
      int? provinceId,
      int? cityId,
      int? lessonId,
      int? topicId,
      int? minPrice,
      int? maxPrice,
      int? schoolId,
      String? currentPage}) {
    return CourseFilter(
      query: query ?? this.query,
      cityName: cityName ?? this.cityName,
      provinceName: provinceName ?? this.provinceName,
      provinceId: provinceId ?? this.provinceId,
      cityId: cityId ?? this.cityId,
      lessonId: lessonId ?? this.lessonId,
      topicId: topicId ?? this.topicId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      schoolId: schoolId ?? this.schoolId,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

String buildUrlWithFilter(String baseUrl, CourseFilter filter) {
  final uri =
      Uri.parse(baseUrl).replace(queryParameters: filter.toQueryParams());
  return uri.toString();
}
