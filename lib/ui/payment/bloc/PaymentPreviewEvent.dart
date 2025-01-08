import '../../course/model/CourseTypeEnum.dart';

abstract class PaymentPreviewEvent {}

class BuyCourse extends PaymentPreviewEvent {
  final int courseId;
   CourseTypeEnum courseType;

  BuyCourse({
    required this.courseId,
    required this.courseType,
  });
}
