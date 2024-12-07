class ApiUrls {
  static const String loginUrl = "/login";
  static const String register = "/register";
  static const String lectures = "/lecture";
  static const String school = "/mobile/school";
  static const String getSchoolWithLogin = "/mobile/school";
  static const String schoolDetail = "/school";
  static const String teacher = "/teacher";
  static const String mainUrl = "https://api.bykurs.com.tr/api/v1";
  static const String gateway = "/api";
  static const String userProfile = "/me";
  static const String topics = "/topic?id=&name=&lesson_id=&grade=";
  static const String getCourses = "/mobile/course";
  static const String getCoursesById = "/course";
  static const String getTimeSheet = "/me/calendar";
  static const String updateUser = "/me/update";
  static const String courseRequestURL = "/mobile/courseRequest";
  static const String getCoursesById2 = "?order[id]=desc&load[0]=school:id,user_id&load[1]=school.user:id,name&load[2]=lesson:id,name,color&load[3]=teacher:id,user_id&load[4]=teacher.user:id,name";

  static String buyCourse(int id) => "/course/$id/buy";
  static const String getFavorites = "/mobile/favorites";
  static const String getHomePage = "/mobile/homepage";
  static const String getHomePageWithLogin = "/mobile/homepage";
  static const String getProvinceAllURL = "https://api.bykurs.com.tr/api/v1/mobile/province/inuse";

  static String getAllDistrictsAllURL(int id) => "https://api.bykurs.com.tr/api/v1/mobile/city/inuse?province_id=$id";

  static String getCourseRequestSchoolsById(int cityId, int provinceId) {
    String baseUrl =
        "https://api.bykurs.com.tr/api/v1/mobile/courseRequest/getSchools";
    return provinceId == 0
        ? "$baseUrl?province_id=$cityId"
        : "$baseUrl?province_id=$cityId&city_id=$provinceId";
  }

  static const String getCourseRequestSchools = "https://api.bykurs.com.tr/api/v1/mobile/courseRequest/getSchools";

  static String toggleFavorite(int id) => "/mobile/favorites/$id";

  static String schoolSearch(String query) => "/mobile/school?name=$query";
}
