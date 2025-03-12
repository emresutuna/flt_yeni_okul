import 'package:baykurs/ui/filter/bloc/FilterEvent.dart';
import 'package:baykurs/ui/filter/bloc/FilterState.dart';
import 'package:bloc/bloc.dart';

import '../../../repository/lecture_repository.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final LectureRepository lectureRepository;

  FilterBloc({required this.lectureRepository}) : super(FilterStateLoading()) {
    on<FetchMaxPrice>((event, emit) async {
      emit(FilterStateLoading());
      try {
        final result =
            await lectureRepository.getMaxPrice(event.courseTypeEnum);
        emit(FilterStateSuccess(result.data!));
      } catch (e) {
        emit(FilterStateError('Failed to fetch MaxPrice'));
      }
    });
  }
}
