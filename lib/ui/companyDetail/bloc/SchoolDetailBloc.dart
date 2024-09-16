import 'package:bloc/bloc.dart';
import 'package:yeni_okul/ui/companyDetail/bloc/SchoolDetailEvent.dart';
import 'package:yeni_okul/ui/companyDetail/bloc/SchoolDetailState.dart';

import '../../../repository/SchoolRepository.dart';

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
  }
}