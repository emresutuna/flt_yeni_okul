import 'package:baykurs/ui/payment/model/PaymentResponse.dart';

import '../makePayment/model/PaymentBillModel.dart';

abstract class PaymentPreviewState {}


class PaymentPreviewLoadingState extends PaymentPreviewState {}
class PaymentPreviewDefaultState extends PaymentPreviewState {}

class PaymentPreviewSuccess extends PaymentPreviewState {
  final PaymentResponse paymentResponse;

  PaymentPreviewSuccess(this.paymentResponse);
}

class PaymentPreviewError extends PaymentPreviewState {
  final String error;

  PaymentPreviewError(this.error);
}
class PaymentBillLoadedState extends PaymentPreviewState {
  final PaymentBillModel paymentBill;

  PaymentBillLoadedState(this.paymentBill);
}

class PaymentBillErrorState extends PaymentPreviewState {
  final String message;

  PaymentBillErrorState(this.message);
}
