import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:baykurs/ui/payment/makePayment/PaymentBillPage.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillBloc.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillState.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillResponse.dart';
import 'package:baykurs/ui/payment/model/PaymentPreview.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:baykurs/widgets/GreenPrimaryButton.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../util/HexColor.dart';
import '../../util/PriceFormatter.dart';
import '../../util/YOColors.dart';
import 'PaymentResultPage.dart';
import 'PaymentWebView.dart';
import 'makePayment/paymentBill/PaymentBillList.dart';
import 'makePayment/paymentBill/bloc/PaymentBillEvent.dart';

class PaymentPreviewPage extends StatefulWidget {
  const PaymentPreviewPage({super.key});

  @override
  State<PaymentPreviewPage> createState() => _PaymentPreviewPageState();
}

class _PaymentPreviewPageState extends State<PaymentPreviewPage> {
  PaymentPreview? paymentPreview;
  List<BillList> paymentBillList = [];
  BillList? defaultBill;

  @override
  void initState() {
    super.initState();
    context.read<PaymentBillBloc>().add(FetchBills());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        setState(() {
          paymentPreview =
              ModalRoute.of(context)!.settings.arguments as PaymentPreview;
        });
      }
    });
  }

  void _navigateToPaymentResult(BuildContext context, bool isSuccess) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentResultPage(isSuccess: isSuccess),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<PaymentBillBloc, PaymentBillState>(
          listener: (context, state) {
        if (state is PaymentPreviewSuccess) {
          _navigateToPaymentResult(context, true);
        } else if (state is PaymentPreviewError) {
          _navigateToPaymentResult(context, false);
        }
      }, builder: (context, state) {
        if (state is PaymentBillStateLoading) {
          return Stack(
            children: [_buildWidget(context), const GlobalFadeAnimation()],
          );
        }
        if (state is PaymentBillStateSuccess) {
          paymentBillList = state.response.data ?? [];
          if (paymentBillList.isNotEmpty) {
            defaultBill = paymentBillList.firstWhere(
              (bill) => bill.isDefault == true,
              orElse: () => BillList(),
            );
          }
        }
        return _buildWidget(context);
      }),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            WhiteAppBar("Ders Satın Al"),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Satın alma işlemini tamamla ve yüz yüze eğitimin özgün modelinde yerini al.',
                        style: styleBlack14Regular,
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 20),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: paymentBorder,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              8.toHeight,
                              Text(
                                'Satın Alınan Ders',
                                style: styleBlack16Bold,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Satın aldığın dersleri, “Ders Programı” sekmesinde görüntüleyebilirsin.',
                                style: styleBlack14Regular,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        paymentPreview?.title ?? "",
                                        style: styleBlack14Bold,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: HexColor(BranchesExtension
                                                  .getColorForBranch(
                                                paymentPreview?.lessonName ??
                                                    "Ders bulunamadı",
                                              ) ??
                                              DEFAULT_LESSON_COLOR),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          paymentPreview?.lessonName ??
                                              "Ders bulunamadı",
                                          style: styleWhite12Bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        paymentPreview?.schoolName ??
                                            "Kurum ismi bulunamadı",
                                        style: styleBlack12Bold,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        paymentPreview?.startDate ?? "",
                                        style: styleBlack12Regular,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        paymentPreview?.classroom ?? "",
                                        style: styleBlack12Regular,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            formatPrice(
                                                paymentPreview?.price ?? ""),
                                            style: styleGreen18Bold,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              16.toHeight,
                              SizedBox(
                                height: 50,
                                width: double.maxFinite,
                                child: GreenPrimaryButton(
                                  text: "Devam Et",
                                  onPress: () {
                                    if (defaultBill != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PaymentWebView(
                                              courseId:
                                                  paymentPreview?.id ?? 0),
                                        ),
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Hata",
                                        "Bir fatura ekle",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                      );
                                    }

                                    /*
                                    Navigator.pushNamed(context, '/makePayment',
                                        arguments: paymentPreview);

                                     */
                                  },
                                ),
                              ),
                              16.toHeight
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.toHeight,
            Container(
              margin: const EdgeInsets.all(16),
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
                                  builder: (context) => PaymentBillList(
                                        paymentBillList: paymentBillList,
                                      )),
                            );
                            if (result != null && result is BillList) {
                              defaultBill = result;
                            }
                          },
                          icon: Icon(Icons.edit_note, color: color5),
                        ),
                      ],
                    ),
                    8.toHeight,
                    defaultBill != null
                        ? Container(
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
                                    groupValue: defaultBill != null,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${defaultBill?.title ?? "Fatura Bilgisi Bulunamadı"} / ${defaultBill?.district ?? "Adres Bilgisi Eksik"}",
                                      style: styleBlack12Regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                "Fatura bilgisi bulunmuyor. Lütfen bir fatura ekle.",
                                style: styleBlack12Bold,
                              ),
                              16.toHeight,
                              PrimaryButton(
                                  text: "Fatura Ekle",
                                  onPress: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentBillPage()),
                                    );
                                    if (result != null && result is BillList) {
                                      defaultBill = result;
                                    }
                                  })
                            ],
                          )
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
