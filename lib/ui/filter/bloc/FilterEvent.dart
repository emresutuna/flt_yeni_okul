import 'package:baykurs/ui/course/model/course_type_enum.dart';

abstract class FilterEvent {}
class FetchMaxPrice extends FilterEvent {
  final CourseTypeEnum courseTypeEnum;

  FetchMaxPrice({
    required this.courseTypeEnum,
  });
}