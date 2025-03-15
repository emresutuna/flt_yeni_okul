import 'package:bloc/bloc.dart';

import '../../../repository/user_repository.dart';
import 'ProfileEvent.dart';
import 'ProfileState.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileDefault()) {
    // Registering event handler for FetchUserProfile event
    on<FetchUserProfile>((event, emit) async {
      emit(ProfileLoading());

      final result = await userRepository.getUserProfile();

      if (result.isSuccess) {
        emit(ProfileSuccess(result.data!));
      } else {
        if (result.error is MailNotVerifiedFailure) {
          emit(ProfileError(result.error.message, type: ProfileErrorType.mailNotVerified));
        } else {
          emit(ProfileError(result.error.message, type: ProfileErrorType.general));
        }
      }
    });

    on<ProfileLogoutRequested>((event, emit) async {
      emit(ProfileLoading());
      try {
        final result = await userRepository.logout();
        emit(LogoutSuccess(result.data!));
      } catch (e) {
        emit(LogoutError('Bir Hata Oluştu'));
      }
    });
    on<DeleteAccount>((event, emit) async {
      emit(ProfileLoading());
      try {
        final result = await userRepository.deleteAccount();
        emit(DeleteAccountSuccess(result.data!));
      } catch (e) {
        emit(DeleteAccountError('Bir Hata Oluştu'));
      }
    });
  }
}
