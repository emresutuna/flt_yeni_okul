import 'package:baykurs/ui/requestlesson/model/CourseRequest.dart';

abstract class RequestLessonEvent {}

class RequestLesson extends RequestLessonEvent {
  final CourseRequest request;

  RequestLesson({
    required this.request,
  });
}