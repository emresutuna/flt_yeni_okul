const String loginUrl = "/login";
const String register = "/register";
const String lectures = "/lecture";
const String school = "/school?id&province_id&city_id&name&email&phone";
const String schoolDetail = "/school/";
const String teacher = "/teacher";
const String mainUrl = "https://api.bykurs.com.tr/api/v1";
const String gateway = "/api";
const String userProfile = "/me";
const String topics = "/topic?id=&name=&lesson_id=&grade=";
const String getCourses = "/course?order[id]=desc&load[0]=school:id,user_id&load[1]=school.user:id,name&load[2]=lesson:id,name,color&load[3]=teacher:id,user_id&load[4]=teacher.user:id,name";
const String getCoursesById = "/course";
const String getCoursesById2 = "?order[id]=desc&load[0]=school:id,user_id&load[1]=school.user:id,name&load[2]=lesson:id,name,color&load[3]=teacher:id,user_id&load[4]=teacher.user:id,name";

