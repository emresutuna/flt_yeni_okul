import 'package:baykurs/repository/payment_repository.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewEvent.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:bloc/bloc.dart';

import '../makePayment/model/PaymentBillModel.dart';

class PaymentPreviewBloc
    extends Bloc<PaymentPreviewEvent, PaymentPreviewState> {
  final PaymentRepository paymentRepository;

  PaymentPreviewBloc({required this.paymentRepository})
      : super(PaymentPreviewDefaultState()) {
    on<BuyCourse>((event, emit) async {
      emit(PaymentPreviewLoadingState());
      try {
        final result = await paymentRepository.postBuyCourse(
            event.courseId, event.courseType);
        emit(PaymentPreviewSuccess(result.data!));
      } catch (e) {
        emit(PaymentPreviewError('Failed to fetch courseDetail'));
      }
    });

    on<LoadPaymentBill>((event, emit) async {
      emit(PaymentPreviewLoadingState());
      try {
        final paymentBill = await PaymentBillModel.loadFromPreferences();
        if (paymentBill != null) {
          emit(PaymentBillLoadedState(paymentBill));
        } else {
          emit(PaymentBillErrorState('Fatura bilgisi bulunamadı.'));
        }
      } catch (e) {
        emit(PaymentBillErrorState('Fatura bilgisi yüklenirken hata oluştu.'));
      }
    });
  }
}
