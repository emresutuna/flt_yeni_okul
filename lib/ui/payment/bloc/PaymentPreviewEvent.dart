import '../../course/model/course_type_enum.dart';

abstract class PaymentPreviewEvent {}

class BuyCourse extends PaymentPreviewEvent {
  final int courseId;
   CourseTypeEnum courseType;

  BuyCourse({
    required this.courseId,
    required this.courseType,
  });
}
class LoadPaymentBill extends PaymentPreviewEvent {}

