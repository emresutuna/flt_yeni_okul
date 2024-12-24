import 'package:baykurs/ui/notification/model/NotificationResponse.dart';

abstract class NotificationState {}

class NotificationStateLoading extends NotificationState {}

class NotificationStateSuccess extends NotificationState {
  final NotificationResponse notificationResponse;

  NotificationStateSuccess(this.notificationResponse);
}

class NotificationStateError extends NotificationState {
  final String error;

  NotificationStateError(this.error);
}