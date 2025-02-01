import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillRequest.dart';

abstract class PaymentBillEvent {}

class FetchBills extends PaymentBillEvent {}

class RemoveBill extends PaymentBillEvent {
  final int id;

  RemoveBill({required this.id});
}

class CreateBill extends PaymentBillEvent {
  final PaymentBillRequest request;

  CreateBill({
    required this.request,
  });
}
class FetchSingleBill extends PaymentBillEvent {
  final int id;

  FetchSingleBill({
    required this.id,
  });
}

class UpdateBill extends PaymentBillEvent {
  final PaymentBillRequest request;

  UpdateBill({
    required this.request,
  });
}
