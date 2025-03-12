import 'package:baykurs/ui/timesheet/bloc/TimeSheetEvent.dart';
import 'package:baykurs/ui/timesheet/bloc/TimeSheetState.dart';
import 'package:bloc/bloc.dart';

import '../../../repository/user_repository.dart';

class TimeSheetBloc extends Bloc<TimeSheetEvent, TimeSheetState> {
  final UserRepository userRepository;

  TimeSheetBloc({required this.userRepository})
      : super(TimeSheetLoadingState()) {
    on<FetchTimeSheet>((event, emit) async {
      emit(TimeSheetLoadingState());
      try {
        final result = await userRepository.getUserTimeSheet();
        emit(TimeSheetSuccess(result.data!));
      } catch (e) {
        emit(TimeSheetError('Failed to fetch calendar'));
      }
    });
  }
}
