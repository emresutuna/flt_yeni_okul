abstract class CourseDetailEvent {}

class FetchCourseById extends CourseDetailEvent {
  final int id;

  FetchCourseById({
    required this.id,
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
