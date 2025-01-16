import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/widgets/PrimaryInputField.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/YOColors.dart';
import '../../../widgets/GreenPrimaryButton.dart';
import '../../webViewPage/WebViewPage.dart';
import 'PaymentBillController.dart';

class PaymentBillPage extends StatefulWidget {
  const PaymentBillPage({super.key});

  @override
  State<PaymentBillPage> createState() => _PaymentBillPageState();
}

class _PaymentBillPageState extends State<PaymentBillPage> {
  final FormController controller = Get.put(FormController());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Fatura Bilgileri"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: paymentBorder),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.toHeight,
                    Text(
                      "Faturanız e-posta olarak gönderilecektir. Faturanızı incelemek için mail adresinizi kontrol edin. ",
                      style: styleBlack14Regular,
                    ),
                    8.toHeight,
                    PaymentInputField(
                      controller: controller.adController,
                      hintText: "Ad",
                    ),
                    12.toHeight,
                    PaymentInputField(
                      controller: controller.soyadController,
                      hintText: "Soyad",
                    ),
                    12.toHeight,
                    PaymentInputField(
                      controller: controller.emailController,
                      hintText: "E-posta",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    12.toHeight,
                    PaymentInputField(
                      controller: controller.tcKimlikController,
                      hintText: "TC Kimlik No",
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                    ),
                    12.toHeight,
                    PaymentInputField(
                      maxLength: 4,
                      controller: controller.dogumYiliController,
                      hintText: "Doğum Yılı",
                      keyboardType: TextInputType.number,
                    ),
                    12.toHeight,
                    PaymentInputField(
                      controller: controller.addressController,
                      hintText: "Adres",
                    ),
                    12.toHeight,
                    PaymentInputField(
                      controller: controller.billNameController,
                      hintText: "Fatura Adı",
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            activeColor: color3,
                            value: controller.isCheckboxChecked.value,
                            onChanged: (bool? value) {
                              controller.isCheckboxChecked.value =
                                  value ?? false;
                            },
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Ön Bilgilendirme Formu ",
                                  style: styleBlack12Regular.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: color3,
                                      color: color3),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      openWebView(
                                          'https://www.bykurs.com.tr/privacy',
                                          'Gizlilik Politikası');
                                    },
                                  children: [
                                    TextSpan(
                                        text: "'nu ve ",
                                        style: styleBlack12Regular.copyWith(
                                            decoration: TextDecoration.none)),
                                    TextSpan(
                                      text: "Mesafeli Satış Sözleşmesi",
                                      style: styleBlack12Regular.copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor: color3,
                                          color: color3),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          openWebView(
                                              'https://www.bykurs.com.tr/privacy',
                                              'Gizlilik Politikası');
                                        },
                                    ),
                                    TextSpan(
                                        text: "'ni okudum, onaylıyorum.",
                                        style: styleBlack12Regular.copyWith(
                                            decoration: TextDecoration.none)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    24.toHeight,
                    SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: GreenPrimaryButton(
                        text: "Devam Et",
                        onPress: () async {
                          if (controller.validateAndSubmit()) {
                            final paymentBill = controller.setupPaymentBill(); // Yeni fatura bilgisi
                            Future.delayed(const Duration(milliseconds: 500), () {
                              Navigator.pop(context, paymentBill); // Fatura bilgisini geri döndür
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
