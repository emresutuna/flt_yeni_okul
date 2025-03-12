class SchoolFilter {
  final String? query;
  final String? cityName;
  final String? provinceName;
  final int? provinceId;
  final int? cityId;
  final String? currentPage;

  SchoolFilter({
    this.query,
    this.cityName,
    this.provinceName,
    this.provinceId,
    this.cityId,
    this.currentPage,
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};
    if (query != null && query!.isNotEmpty) params['name'] = query!;
    if (provinceId != null) params['city_id'] = provinceId.toString();
    if (cityId != null) params['province_id'] = cityId.toString();
    if (currentPage != null) params['page'] = currentPage.toString();
    return params;
  }

  SchoolFilter copyWith({
    String? query,
    String? cityName,
    String? provinceName,
    int? provinceId,
    int? cityId,
    String? currentPage
  }) {
    return SchoolFilter(
      query: query ?? this.query,
      cityName: cityName ?? this.cityName,
      provinceName: provinceName ?? this.provinceName,
      provinceId: provinceId ?? this.provinceId,
      cityId: cityId ?? this.cityId,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}


String buildUrlWithFilter(String baseUrl, SchoolFilter filter) {
  final uri = Uri.parse(baseUrl).replace(queryParameters: filter.toQueryParams());
  return uri.toString();
}