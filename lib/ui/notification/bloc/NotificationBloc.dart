import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/notification/bloc/NotificationEvent.dart';
import 'package:baykurs/ui/notification/bloc/NotificationState.dart';
import 'package:bloc/bloc.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final UserRepository userRepository;

  NotificationBloc({required this.userRepository}) : super(NotificationStateLoading()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationStateLoading());
      try {
        final result = await userRepository.getNotifications();
        emit(NotificationStateSuccess(result.data!));
      } catch (e) {
        emit(NotificationStateError('Failed to fetch Notifications'));
      }
    });

    on<UpdateNotificationSeen>((event, emit) async {
      emit(NotificationStateLoading());
      try {
        final result = await userRepository.updateNotificationSeen();
        emit(NotificationStateUpdated());
      } catch (e) {
        emit(NotificationStateError('Failed to update NotificationSeen'));
      }
    });

  }
}
