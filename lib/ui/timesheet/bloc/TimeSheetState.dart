import 'package:baykurs/ui/timesheet/model/TimeSheetResponse.dart';

abstract class TimeSheetState {}

class TimeSheetLoadingState extends TimeSheetState {}

class TimeSheetSuccess extends TimeSheetState {
  final TimeSheetResponse timeSheetResponse;

  TimeSheetSuccess(this.timeSheetResponse);
}

class TimeSheetError extends TimeSheetState {
  final String error;

  TimeSheetError(this.error);
}
