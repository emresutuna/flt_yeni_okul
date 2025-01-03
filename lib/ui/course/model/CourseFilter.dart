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

  CourseFilter({
    this.query,
    this.cityName,
    this.provinceName,
    this.provinceId,
    this.cityId,
    this.lessonId,
    this.topicId,
    this.maxPrice,
    this.minPrice
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};
    if (query != null && query!.isNotEmpty) params['query'] = query!;
    if (provinceId != null) params['city_id'] = provinceId.toString();
    if (cityId != null) params['province_id'] = cityId.toString();
    if (lessonId != null) params['lesson_id'] = lessonId.toString();
    if (topicId != null) params['topic_id'] = topicId.toString();
    if (minPrice != null) params['minPrice'] = minPrice.toString();
    if (maxPrice != null) params['maxPrice'] = maxPrice.toString();
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
      int? maxPrice}) {
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
    );
  }
}
String buildUrlWithFilter(String baseUrl, CourseFilter filter) {
  final uri = Uri.parse(baseUrl).replace(queryParameters: filter.toQueryParams());
  return uri.toString();
}
