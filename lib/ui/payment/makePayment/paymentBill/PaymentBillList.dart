import 'package:baykurs/ui/payment/makePayment/SingleBillPage.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/billListBloc/BillListBloc.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/billListBloc/BillListState.dart';
import 'package:baykurs/util/all_extension.dart';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/PrimaryButton.dart';
import '../PaymentBillPage.dart';
import 'billListBloc/BillListEvent.dart';
import 'model/PaymentBillResponse.dart';

class PaymentBillList extends StatefulWidget {
  const PaymentBillList({super.key});

  @override
  State<PaymentBillList> createState() => _PaymentBillListState();
}

class _PaymentBillListState extends State<PaymentBillList> {
  List<BillList> _paymentBillList = [];

  @override
  void initState() {
    super.initState();
    context.read<BillListBloc>().add(FetchBills());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Fatura Adreslerim"),
      body: BlocListener<BillListBloc, BillListState>(
        listener: (context, state) {
          if (state is PaymentBillStateError || state is PaymentBillRemoveStateError) {
            final errorMsg = state is PaymentBillStateError ? state.error : (state as PaymentBillRemoveStateError).error;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMsg)),
            );
          }

          if (state is BillListStateRemoveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Fatura başarıyla silindi!')),
            );
            context.read<BillListBloc>().add(FetchBills());
          }

          if (state is PaymentBillCreateResponse) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Yeni fatura adresi eklendi!')),
            );
            context.read<BillListBloc>().add(FetchBills());
          }
        },
        child: BlocBuilder<BillListBloc, BillListState>(
          builder: (context, state) {
            if (state is BillListStateLoading) {
              return const GlobalFadeAnimation();
            }

            if (state is PaymentBillStateSuccess) {
              _paymentBillList = state.response.data ?? [];
            }

            return _buildBillList(_paymentBillList);
          },
        ),
      ),
    );
  }

  Widget _buildBillList(List<BillList> paymentBillList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Fatura adreslerini kolayca görüntüleyebilir, düzenleyebilir ve silebilirsin",
            style: styleBlack14Regular,
          ),
          16.toHeight,
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: paymentBorder),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Fatura Adresi Ekle", style: styleBlack16Bold),
                      ),
                    ],
                  ),
                  8.toHeight,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Mevcut fatura bilginiz yoksa bir fatura adresi ekleyerek satın alma işlemi yapabilir, ya da güncel bilgilerinizle yeni bir fatura adresi ekleyebilirsin.",
                          style: styleBlack12Regular,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PrimaryButton(
                      text: 'Fatura Adresi Ekle',
                      onPress: _addNewBill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          paymentBillList.isNotEmpty
              ? Expanded(
            child: ListView.builder(
              itemCount: paymentBillList.length,
              itemBuilder: (context, index) {
                final data = paymentBillList[index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SinglePaymentBillPage(id: data.id??0,),
                    ),);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (data.isDefault ?? false) ? color3 : paymentBorder,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Adres Adı: ", style: styleBlack12Bold),
                                      TextSpan(text: data.title ?? "Adres Bilgisi Eksik", style: styleBlack12Regular),
                                    ],
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              InkWell(
                                onTap: () => _removeBill(data.id ?? 0),
                                child: const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                          8.toHeight,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "Adres Detayı: ", style: styleBlack12Bold),
                                TextSpan(text: data.district ?? "Adres Bilgisi Eksik", style: styleBlack12Regular),
                              ],
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
              : Expanded(
            child: Center(
              child: Text(
                "Fatura adresi bulunmamaktadır.",
                style: styleBlack14Regular,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewBill() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentBillPage()),
    );

    if (result != null && result is BillList) {
    }
  }

  void _removeBill(int billId) {
    context.read<BillListBloc>().add(RemoveBill(id: billId));
  }
}

