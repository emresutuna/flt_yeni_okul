import '../model/UserUpdateRequest.dart';

abstract class UserUpdateEvent {}

class UserUpdateRequest extends UserUpdateEvent {
  final UserUpdateRequestModel request;

  UserUpdateRequest({
    required this.request,
  });
}