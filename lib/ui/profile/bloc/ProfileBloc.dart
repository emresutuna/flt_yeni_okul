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
      try {
        final result = await userRepository.getUserProfile();
        emit(ProfileSuccess(result.data!));
      } catch (e) {
        emit(ProfileError('Failed to fetch users'));
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
