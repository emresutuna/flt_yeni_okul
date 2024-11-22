import 'package:baykurs/repository/userRepository.dart';
import 'package:baykurs/ui/dashboard/bloc/DashboardEvent.dart';
import 'package:baykurs/ui/dashboard/bloc/DashboardState.dart';
import 'package:bloc/bloc.dart';




class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserRepository userRepository;

  DashboardBloc({required this.userRepository}) : super(DashboardLoading()) {
    on<FetchDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final result = await userRepository.getDashboard();
        emit(DashboardSuccess(result.data!));
      } catch (e) {
        emit(DashboardError('Failed to fetch users'));
      }
    });
  }
}