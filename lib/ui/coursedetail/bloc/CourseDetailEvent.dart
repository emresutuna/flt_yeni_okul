abstract class CourseDetailEvent {}


class FetchCourseById extends CourseDetailEvent {
  final int id;

  FetchCourseById({
    required this.id,
  });
}