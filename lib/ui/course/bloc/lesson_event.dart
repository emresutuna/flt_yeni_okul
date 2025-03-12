import '../model/course_filter.dart';

abstract class LessonEvent {}

class FetchLesson extends LessonEvent {}
class FetchCourseBundle extends LessonEvent{}

class FetchLessonWithFilter extends LessonEvent {
  final CourseFilter courseFilter;

  FetchLessonWithFilter({
    required this.courseFilter,
  });
}
class FetchCourseBundleWithFilter extends LessonEvent {
  final CourseFilter courseFilter;

  FetchCourseBundleWithFilter({
    required this.courseFilter,
  });
}

class FetchCourseCoach extends LessonEvent {}

class FetchCourseCoachDetail extends LessonEvent {
  final int id;

  FetchCourseCoachDetail({required this.id});
}

class FetchCourseCoachWithFilter extends LessonEvent {
  final CourseFilter courseFilter;

  FetchCourseCoachWithFilter({
    required this.courseFilter,
  });
}
