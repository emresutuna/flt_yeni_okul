import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/PrimaryButton.dart';
import 'model/PaymentBillResponse.dart';

class PaymentBillList extends StatefulWidget {
  final List<BillList> paymentBillList;

  const PaymentBillList({super.key, required this.paymentBillList});

  @override
  State<PaymentBillList> createState() => _PaymentBillListState();
}

class _PaymentBillListState extends State<PaymentBillList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Fatura Adreslerim"),
      body: Padding(
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
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8,top: 16,bottom: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Fatura Adresi Ekle",
                            style: styleBlack16Bold,
                          ),
                        ),
                      ],
                    ),
                    8.toHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          onPress: () {
                            _addNewBill();
                          },
                        )),
                  ],
                ),
              ),
            ),
            widget.paymentBillList.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: widget.paymentBillList.length,
                      itemBuilder: (context, index) {
                        final data = widget.paymentBillList[index];
                        return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: (data.isDefault ?? false)
                                    ? color3
                                    : paymentBorder),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Adres Adı: ",
                                              style: styleBlack12Bold,
                                            ),
                                            TextSpan(
                                              text: data.title ??
                                                  "Adres Bilgisi Eksik",
                                              style: styleBlack12Regular,
                                            ),
                                          ],
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => _removeBill(index),
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Adres Detayı: ",
                                        style: styleBlack12Bold,
                                      ),
                                      TextSpan(
                                        text: data.district ??
                                            "Adres Bilgisi Eksik",
                                        style: styleBlack12Regular,
                                      ),
                                    ],
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _addNewBill() {
    setState(() {
      // widget.paymentBillList.add("Yeni Fatura ${bills.length + 1}");
    });
  }

  void _removeBill(int index) {
    setState(() {
      widget.paymentBillList.removeAt(index);
    });
  }
}
