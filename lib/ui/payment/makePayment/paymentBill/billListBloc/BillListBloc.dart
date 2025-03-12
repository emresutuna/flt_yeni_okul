import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/billListBloc/BillListEvent.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/billListBloc/BillListState.dart';

import 'package:bloc/bloc.dart';

class BillListBloc extends Bloc<BillListEvent, BillListState> {
  final UserRepository userRepository;

  BillListBloc({required this.userRepository}) : super(BillListStateLoading()) {
    // Registering event handler for FetchLesson event
    on<FetchBills>((event, emit) async {
      emit(BillListStateLoading());

      try {
        final result = await userRepository.getPaymentBills();
        emit(PaymentBillStateSuccess(result.data!));
      } catch (e) {
        emit(PaymentBillStateError('Fatura adresi bulunmuyor'));
      }
    });

    on<RemoveBill>((event, emit) async {
      emit(BillListStateLoading());

      try {
        final result = await userRepository.removeBill(event.id);
        emit(BillListStateRemoveSuccess(result.data!));
      } catch (e) {
        emit(PaymentBillStateError('Fatura adresi silinemedi'));
      }
    });
  }
}
