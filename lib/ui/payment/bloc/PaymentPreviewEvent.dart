abstract class PaymentPreviewEvent {}

class BuyCourse extends PaymentPreviewEvent {
  final int courseId;

  BuyCourse({
    required this.courseId,
  });
}
