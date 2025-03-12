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
      return CourseTypeEnum.course; // Default fallback
  }
}