import '../model/CourseFilter.dart';

abstract class LessonEvent {}


class FetchLesson extends LessonEvent {
}
class FetchLessonWithFilter extends LessonEvent {
  final CourseFilter courseFilter;

  FetchLessonWithFilter({
    required this.courseFilter,
  });
}