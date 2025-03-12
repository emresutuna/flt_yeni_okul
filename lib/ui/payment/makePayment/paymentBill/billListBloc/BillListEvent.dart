import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillRequest.dart';

abstract class BillListEvent {}

class FetchBills extends BillListEvent {}

class RemoveBill extends BillListEvent {
  final int id;

  RemoveBill({required this.id});
}

class CreateBill extends BillListEvent {
  final PaymentBillRequest request;

  CreateBill({
    required this.request,
  });
}
