import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';

abstract class FilterEvent {}
class FetchMaxPrice extends FilterEvent {
  final CourseTypeEnum courseTypeEnum;

  FetchMaxPrice({
    required this.courseTypeEnum,
  });
}