import 'package:baykurs/repository/paymentReposityory.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewEvent.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:bloc/bloc.dart';

class PaymentPreviewBloc
    extends Bloc<PaymentPreviewEvent, PaymentPreviewState> {
  final PaymentRepository paymentRepository;

  PaymentPreviewBloc({required this.paymentRepository})
      : super(PaymentPreviewDefaultState()) {
    on<BuyCourse>((event, emit) async {
      emit(PaymentPreviewLoadingState());
      try {
        final result = await paymentRepository.postBuyCourse(event.courseId);
        emit(PaymentPreviewSuccess(result.data!));
      } catch (e) {
        emit(PaymentPreviewError('Failed to fetch courseDetail'));
      }
    });
  }
}
