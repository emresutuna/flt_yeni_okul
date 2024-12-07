import 'package:bloc/bloc.dart';

import '../../../repository/SchoolRepository.dart';
import 'SchoolEvent.dart';
import 'SchoolState.dart';

class SchoolBloc extends Bloc<SchoolEvent, SchoolState> {
  final SchoolRepository schoolRepository;


  SchoolBloc({required this.schoolRepository}) : super(SchoolDefault()) {
    // Registering event handler for FetchSchool event
    on<FetchSchool>((event, emit) async {
      emit(SchoolLoading());
      try {
        final result = await schoolRepository.getSchool();
        emit(SchoolSuccess(result.data!));
      } catch (e) {
        emit(SchoolError('Failed to fetch users'));
      }
    });

    on<SearchSchool>((event, emit) async {
      emit(SchoolLoading());
      try {
        final result = await schoolRepository.getSchoolBySearch(event.schoolFilter);
        emit(SchoolSuccess(result.data!));
      } catch (e) {
        emit(SchoolError('Sonuç Bulunamadı'));
      }
    });

    on<ToggleFavorite>((event, emit) async {
      try {
        final result = await schoolRepository.toggleFav(event.schoolId);
      } catch (e) {
        emit(FavoriteError('Failed to Favorite'));
      }
    });

  }

}