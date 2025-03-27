import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillEvent.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillState.dart';
import 'package:bloc/bloc.dart';

class PaymentBillBloc extends Bloc<PaymentBillEvent, PaymentBillState> {
  final UserRepository userRepository;

  PaymentBillBloc({required this.userRepository})
      : super(PaymentBillStateLoading()) {
    on<FetchBills>((event, emit) async {
      emit(PaymentBillStateLoading());

      final result = await userRepository.getPaymentBills();

      if (result.isSuccess) {
        emit(PaymentBillStateSuccess(result.data!));
      } else {
        emit(PaymentBillStateError(result.error.toString()));
      }
    });
  }
}
