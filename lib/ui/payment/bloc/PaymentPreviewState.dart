import 'package:baykurs/ui/payment/model/PaymentResponse.dart';

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
