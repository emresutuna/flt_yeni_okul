import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolEvent.dart';
import 'package:baykurs/ui/favoriteschool/bloc/FavoriteSchoolState.dart';
import 'package:bloc/bloc.dart';

class FavoriteSchoolBloc
    extends Bloc<FavoriteSchoolEvent, FavoriteSchoolState> {
  final UserRepository userRepository;

  FavoriteSchoolBloc({required this.userRepository})
      : super(FavoriteSchoolDefault()) {
    on<FetchFavorites>((event, emit) async {
      emit(FavoriteSchoolLoading());
      try {
        final result = await userRepository.getFavorites();
        emit(FavoriteSchoolSuccess(result.data!));
      } catch (e) {
        emit(FavoriteSchoolError('Failed to fetch favorites'));
      }
    });

    on<ToggleFavorite>((event, emit) async {
      try {
        final result = await userRepository.toggleFav(event.schoolId);

      } catch (e) {
        emit(FavoriteSchoolError('Failed to fetch favorites'));
      }
    });
  }
}
