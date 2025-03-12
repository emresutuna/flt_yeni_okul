import 'package:baykurs/ui/dashboard/model/mobile_home_response.dart';

abstract class DashboardState {}


class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final MobileHomeResponse mobileHomeResponse;

  DashboardSuccess(this.mobileHomeResponse);
}

class DashboardError extends DashboardState {
  final String error;

  DashboardError(this.error);
}