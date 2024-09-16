import 'package:bloc/bloc.dart';
import 'package:yeni_okul/repository/userRepository.dart';
import 'package:yeni_okul/ui/profile/bloc/ProfileEvent.dart';
import 'package:yeni_okul/ui/profile/bloc/ProfileState.dart';

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
  }
}
