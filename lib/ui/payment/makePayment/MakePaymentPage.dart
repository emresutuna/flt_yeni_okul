import 'package:baykurs/ui/payment/makePayment/PaymentBillPage.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../util/YOColors.dart';
import '../../../widgets/GreenPrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';
import '../../../widgets/WhiteAppBar.dart';
import '../../webViewPage/WebViewPage.dart';
import '../PaymentResultPage.dart';
import '../bloc/PaymentPreviewBloc.dart';
import '../bloc/PaymentPreviewEvent.dart';
import '../bloc/PaymentPreviewState.dart';
import '../model/PaymentPreview.dart';
import 'PaymentController.dart';
import 'model/PaymentBillModel.dart';

class MakePaymentPage extends StatefulWidget {
  const MakePaymentPage({super.key});

  @override
  State<MakePaymentPage> createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {
  final ValueNotifier<PaymentBillModel?> paymentBillNotifier =
      ValueNotifier(null);
  final CreditCardInputController controller =
      Get.put(CreditCardInputController());
  PaymentPreview? paymentPreview;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentPreviewBloc>().add(LoadPaymentBill());
      if (ModalRoute.of(context) != null) {
        setState(() {
          paymentPreview =
              ModalRoute.of(context)!.settings.arguments as PaymentPreview;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.clearAllFields();
  }

  void getPaymentBill() async {
    PaymentBillModel? model = await PaymentBillModel.loadFromPreferences();
    paymentBillNotifier.value = model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Ödeme Yap"),
      body: BlocConsumer<PaymentPreviewBloc, PaymentPreviewState>(
          listener: (context, state) {
        if (state is PaymentPreviewSuccess) {
          _navigateToPaymentResult(context, true);
        } else if (state is PaymentPreviewError) {
          _navigateToPaymentResult(context, false);
        }
      }, builder: (context, state) {
        if (state is PaymentPreviewLoadingState) {
          return Stack(
            children: [
              _buildWidget(),
              Center(
                  child: CircularProgressIndicator(
                color: color5,
              )),
            ],
          );
        }
        if (state is PaymentBillLoadedState) {
          paymentBillNotifier.value = state.paymentBill;
          _buildWidget();
        }
        return _buildWidget();
      }),
    );
  }

  void _navigateToPaymentResult(BuildContext context, bool isSuccess) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentResultPage(isSuccess: isSuccess),
      ),
    );
  }

  _buildWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: paymentBorder),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.toHeight,
                  Text(
                    "Kredi veya banka kartı bilgilerinizi girerek işlemlere devam edebilirsiniz. Lütfen, güncel kart bilgilerinizi kullandığınızdan emin olun.",
                    style: styleBlack14Regular,
                  ),
                  16.toHeight,
                  PaymentInputField(
                    controller: controller.nameController,
                    hintText: "Kart Sahibi",
                  ),
                  12.toHeight,
                  PaymentInputField(
                    maxLength: 19,
                    controller: controller.cardNumberController,
                    hintText: "Kart Numarası",
                    keyboardType: TextInputType.number,
                  ),
                  12.toHeight,
                  Text(
                    "Son Kullanma Tarihi",
                    style: styleBlack14Bold,
                  ),
                  4.toHeight,
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        // Dropdown for Month
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            iconSize: 16,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              hintText: "Ay",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: paymentBorder),
                              ),
                            ),
                            items: List.generate(12, (index) {
                              return DropdownMenuItem(
                                value: (index + 1).toString(),
                                child: Text(
                                  (index + 1).toString().padLeft(2, '0'),
                                  style: styleBlack14Bold,
                                ),
                              );
                            }),
                            onChanged: (value) {
                              controller.monthController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Dropdown for Year
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            iconSize: 16,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                              hintText: "Yıl",
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: paymentBorder),
                              ),
                            ),
                            items: List.generate(10, (index) {
                              final year = DateTime.now().year + index;
                              return DropdownMenuItem(
                                value: year.toString(),
                                child: Text(
                                  year.toString(),
                                  style: styleBlack14Bold,
                                ),
                              );
                            }),
                            onChanged: (value) {
                              controller.yearController.text = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.toHeight,
                  Text(
                    "Güvenlik Kodu",
                    style: styleBlack14Bold,
                  ),
                  4.toHeight,
                  PaymentInputField(
                    controller: controller.cvvController,
                    hintText: "CVV",
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/iyzico_logo.png',
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: paymentBorder),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  8.toHeight,
                  Text(
                    "Özet ",
                    style: styleBlack16Bold,
                  ),
                  8.toHeight,
                  Text(
                    "Hizmet Bedeli ",
                    style: styleBlack14Bold,
                  ),
                  8.toHeight,
                  Row(
                    children: [
                      Text("Detay: ", style: styleBlack14Bold),
                      Text(
                        "${paymentPreview?.title ?? ""} - ${paymentPreview?.lessonName ?? "-"}",
                        style: styleBlack14Regular,
                      ),
                    ],
                  ),
                  Text(
                    "Satın aldığınız hizmete ait tutar bilgisi aşağıdadır",
                    style: styleBlack14Regular,
                  ),
                  16.toHeight,
                  Divider(
                    color: Colors.grey.shade300,
                    height: 0.5,
                  ),
                  16.toHeight,
                  Row(
                    children: [
                      const Text("Ödenecek Tutar : "),
                      Expanded(
                          child: Text(
                        "₺${paymentPreview?.price ?? "-"}",
                        style: styleBlack22Bold.copyWith(color: color3),
                      ))
                    ],
                  ),
                  16.toHeight,
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: paymentBorder),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fatura Bilgisi ",
                        style: styleBlack16Bold,
                      ),
                      IconButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentBillPage()),
                          );
                          if (result != null && result is PaymentBillModel) {
                            paymentBillNotifier.value =
                                result; // UI'yı güncelle
                          }
                        },
                        icon: Icon(Icons.edit_note, color: color3),
                      ),
                    ],
                  ),
                  8.toHeight,
                  ValueListenableBuilder<PaymentBillModel?>(
                    valueListenable: paymentBillNotifier,
                    builder: (context, paymentBillModel, child) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: paymentBorder),
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: true,
                                onChanged: (value) {},
                                activeColor: color3,
                                hoverColor: color3,
                                groupValue: paymentBillModel != null,
                              ),
                              Expanded(
                                child: Text(
                                  "${paymentBillModel?.billName ?? "Fatura Bilgisi Bulunamadı"} / ${paymentBillModel?.address ?? "Adres Bilgisi Eksik"}",
                                  style: styleBlack12Regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Obx(
                () => Checkbox(
                  activeColor: color3,
                  value: controller.isCheckboxChecked.value,
                  onChanged: (bool? value) {
                    controller.isCheckboxChecked.value = value ?? false;
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
                            openWebView('https://www.bykurs.com.tr/privacy',
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
                                openWebView('https://www.bykurs.com.tr/privacy',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 50,
              width: double.maxFinite,
              child: GreenPrimaryButton(
                text: "Ödeme Yap",
                onPress: () {
                  if (controller.validateAndSubmit()) {
                    context.read<PaymentPreviewBloc>().add(BuyCourse(
                        courseId: paymentPreview?.id ?? 0,
                        courseType: paymentPreview!.courseType!));
                  }
                },
              ),
            ),
          ),
          24.toHeight,
        ],
      ),
    );
  }
}
