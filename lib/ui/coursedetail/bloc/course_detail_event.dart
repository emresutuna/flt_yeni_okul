abstract class CourseDetailEvent {}

class FetchCourseById extends CourseDetailEvent {
  final int id;
  final bool? isIncomingLesson;

  FetchCourseById({
    required this.id,
    this.isIncomingLesson,
  });
}


class FetchCourseBundleById extends CourseDetailEvent {
  final int id;
  FetchCourseBundleById({
    required this.id,
  });
}

class FetchCourseCoachById extends CourseDetailEvent {
  final int id;
  FetchCourseCoachById({
    required this.id,
  });
}
