import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillResponse.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/model/SinglePaymentBillResponse.dart';

abstract class PaymentBillState {}

class PaymentBillStateLoading extends PaymentBillState {}

class PaymentBillStateSuccess extends PaymentBillState {
  final PaymentBillResponse response;

  PaymentBillStateSuccess(this.response);
}

class PaymentBillStateSingleSuccess extends PaymentBillState {
  final SinglePaymentBillResponse response;

  PaymentBillStateSingleSuccess(this.response);
}

class PaymentBillCreateResponse extends PaymentBillState {
  final SinglePaymentBillResponse response;

  PaymentBillCreateResponse(this.response);
}

class PaymentBillStateError extends PaymentBillState {
  final String error;

  PaymentBillStateError(this.error);
}
