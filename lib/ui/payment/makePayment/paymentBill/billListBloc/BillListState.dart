import 'package:baykurs/ui/payment/makePayment/paymentBill/model/BillResultResponse.dart';

import '../model/PaymentBillResponse.dart';
import '../model/SinglePaymentBillResponse.dart';

abstract class BillListState {}

class BillListStateLoading extends BillListState {}

class BillListStateSuccess extends BillListState {
  final PaymentBillResponse response;

  BillListStateSuccess(this.response);
}

class BillListStateRemoveSuccess extends BillListState {
  final BillResultResponse response;

  BillListStateRemoveSuccess(this.response);
}
class PaymentBillStateSuccess extends BillListState {
  final PaymentBillResponse response;

  PaymentBillStateSuccess(this.response);
}
class PaymentBillCreateResponse extends BillListState {
  final SinglePaymentBillResponse response;

  PaymentBillCreateResponse(this.response);
}

class PaymentBillStateError extends BillListState {
  final String error;

  PaymentBillStateError(this.error);
}
class PaymentBillRemoveStateError extends BillListState {
  final String error;

  PaymentBillRemoveStateError(this.error);
}
