enum CourseTypeEnum { course, courseBundle, courseCoach }

CourseTypeEnum mapCourseType(int type) {
  switch (type) {
    case 0:
      return CourseTypeEnum.course;
    case 1:
      return CourseTypeEnum.courseBundle;
    case 2:
      return CourseTypeEnum.courseCoach;
    default:
      return CourseTypeEnum.course;
  }
}

String courseTypeEnumToString(CourseTypeEnum type) {
  switch (type) {
    case CourseTypeEnum.course:
      return "Ders";
    case CourseTypeEnum.courseBundle:
      return "Kurs";
    case CourseTypeEnum.courseCoach:
      return "Eğitim Koçu";
  }
}

CourseTypeEnum stringToCourseTypeEnum(String label) {
  switch (label) {
    case "Ders":
      return CourseTypeEnum.course;
    case "Kurs":
      return CourseTypeEnum.courseBundle;
    case "Eğitim Koçu":
      return CourseTypeEnum.courseCoach;
    default:
      return CourseTypeEnum.course;
  }
}
int mapCourseTypeToInt(CourseTypeEnum type) {
  switch (type) {
    case CourseTypeEnum.course:
      return 0;
    case CourseTypeEnum.courseBundle:
      return 1;
    case CourseTypeEnum.courseCoach:
      return 2;
    default:
      return 0; // fallback
  }
}
extension CourseTypeEnumExtension on CourseTypeEnum {
  String get label {
    switch (this) {
      case CourseTypeEnum.course:
        return "Ders";
      case CourseTypeEnum.courseBundle:
        return "Kurs";
      case CourseTypeEnum.courseCoach:
        return "Eğitim Koçu";
    }
  }

  int get typeId {
    switch (this) {
      case CourseTypeEnum.course:
        return 0;
      case CourseTypeEnum.courseBundle:
        return 1;
      case CourseTypeEnum.courseCoach:
        return 2;
    }
  }
}
