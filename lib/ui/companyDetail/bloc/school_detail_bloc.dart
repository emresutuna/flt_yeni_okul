import 'package:bloc/bloc.dart';
import '../../../repository/school_repository.dart';
import 'school_detail_event.dart';
import 'school_detail_state.dart';

class SchoolDetailBloc extends Bloc<SchoolDetailEvent, SchoolDetailState> {
  final SchoolRepository schoolRepository;

  SchoolDetailBloc({required this.schoolRepository}) : super(SchoolDetailDefault()) {
    // Registering event handler for FetchSchoolBy event
    on<FetchSchoolById>((event, emit) async {
      emit(SchoolDetailLoading());
      try {
        final result = await schoolRepository.getSchoolById(event.id);
        emit(SchoolDetailSuccess(result.data!));
      } catch (e) {
        emit(SchoolDetailError('Failed to fetch users'));
      }
    });
    on<ToggleFavorite>((event, emit) async {
      try {
       await schoolRepository.toggleFav(event.schoolId);
      } catch (e) {
        emit(FavoriteError('Failed to Favorite'));
      }
    });
  }
}