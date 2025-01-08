enum CourseTypeEnum { COURSE, COURSE_BUNDLE, COURSE_COACH }
CourseTypeEnum mapCourseType(int type) {
  switch (type) {
    case 0:
      return CourseTypeEnum.COURSE;
    case 1:
      return CourseTypeEnum.COURSE_BUNDLE;
    case 2:
      return CourseTypeEnum.COURSE_COACH;
    default:
      return CourseTypeEnum.COURSE; // Default fallback
  }
}