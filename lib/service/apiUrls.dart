class ApiUrls{
  static const String loginUrl = "/login";
  static const String register = "/register";
  static const String lectures = "/lecture";
  static const String school = "/school?id&province_id&city_id&name&email&phone";
  static const String schoolDetail = "/school";
  static const String teacher = "/teacher";
  static const String mainUrl = "https://api.bykurs.com.tr/api/v1";
  static const String gateway = "/api";
  static const String userProfile = "/me";
  static const String topics = "/topic?id=&name=&lesson_id=&grade=";
  static const String getCourses = "/course?order[id]=desc&load[0]=school:id,user_id&load[1]=school.user:id,name&load[2]=lesson:id,name,color&load[3]=teacher:id,user_id&load[4]=teacher.user:id,name";
  static const String getCoursesById = "/course";
  static const String getTimeSheet = "/me/calendar";
  static const String updateUser = "/me/update";
  static const String getCoursesById2 = "?order[id]=desc&load[0]=school:id,user_id&load[1]=school.user:id,name&load[2]=lesson:id,name,color&load[3]=teacher:id,user_id&load[4]=teacher.user:id,name";
  static  String buyCourse(int id) => "/course/$id/buy";
}


