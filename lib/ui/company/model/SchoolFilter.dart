class SchoolFilter {
  final String? query;
  final String? cityName;
  final String? provinceName;
  final int? provinceId;
  final int? cityId;

  SchoolFilter({
    this.query,
    this.cityName,
    this.provinceName,
    this.provinceId,
    this.cityId,
  });

  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};
    if (query != null && query!.isNotEmpty) params['query'] = query!;
    if (provinceId != null) params['province_id'] = provinceId.toString();
    if (cityId != null) params['city_id'] = cityId.toString();
    return params;
  }

  SchoolFilter copyWith({
    String? query,
    String? cityName,
    String? provinceName,
    int? provinceId,
    int? cityId,
  }) {
    return SchoolFilter(
      query: query ?? this.query,
      cityName: cityName ?? this.cityName,
      provinceName: provinceName ?? this.provinceName,
      provinceId: provinceId ?? this.provinceId,
      cityId: cityId ?? this.cityId,
    );
  }
}


String buildUrlWithFilter(String baseUrl, SchoolFilter filter) {
  final uri = Uri.parse(baseUrl).replace(queryParameters: filter.toQueryParams());
  return uri.toString();
}