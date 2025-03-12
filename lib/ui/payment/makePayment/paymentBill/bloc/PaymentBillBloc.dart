import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillEvent.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillState.dart';
import 'package:bloc/bloc.dart';

class PaymentBillBloc extends Bloc<PaymentBillEvent, PaymentBillState> {
  final UserRepository userRepository;

  PaymentBillBloc({required this.userRepository}) : super(PaymentBillStateLoading()) {
    // Registering event handler for FetchLesson event
    on<FetchBills>((event, emit) async {
      emit(PaymentBillStateLoading());

      try {
        final result = await userRepository.getPaymentBills();
        emit(PaymentBillStateSuccess(result.data!));
      } catch (e) {
        emit(PaymentBillStateError('Failed to fetch PaymentBill'));
      }
    });

  }
}
