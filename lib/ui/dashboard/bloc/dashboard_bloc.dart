import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/service/result_response.dart';
import 'package:baykurs/ui/dashboard/bloc/dashboard_event.dart';
import 'package:baykurs/ui/dashboard/bloc/dashboard_state.dart';
import 'package:bloc/bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserRepository userRepository;

  DashboardBloc({required this.userRepository}) : super(DashboardLoading()) {
    on<FetchDashboard>((event, emit) async {
      emit(DashboardLoading());

      try {
        final result = await userRepository.getDashboard();

        if (!result.isSuccess) {
          emit(DashboardError(result.error?.toString() ?? 'Bilinmeyen hata'));
          return;
        }

        final mobileHomeResponse = result.data;

        if (mobileHomeResponse == null) {
          emit(DashboardError('Veri bulunamadı.'));
          return;
        }

        if (mobileHomeResponse.status != true) {
          emit(
              DashboardError('API durum hatası: ${mobileHomeResponse.status}'));
          return;
        }

        // Tüm kontroller geçtiyse başarılı state
        emit(DashboardSuccess(mobileHomeResponse));
      } catch (e, stacktrace) {
        emit(DashboardError('Veri alınırken bir hata oluştu: $e'));
      }
    });
  }
}
