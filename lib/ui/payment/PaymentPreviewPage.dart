import 'package:baykurs/ui/course/model/CourseTypeEnum.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewBloc.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewEvent.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:baykurs/ui/payment/makePayment/MakePaymentPage.dart';
import 'package:baykurs/ui/payment/makePayment/PaymentBillPage.dart';
import 'package:baykurs/ui/payment/model/PaymentPreview.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:baykurs/widgets/GreenPrimaryButton.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/HexColor.dart';
import '../../util/YOColors.dart';
import '../coursedetail/model/CourseDetailResponseModel.dart';
import 'PaymentResultPage.dart';

class PaymentPreviewPage extends StatefulWidget {
  const PaymentPreviewPage({super.key});

  @override
  State<PaymentPreviewPage> createState() => _PaymentPreviewPageState();
}

class _PaymentPreviewPageState extends State<PaymentPreviewPage> {
  PaymentPreview? paymentPreview;

  @override
  void initState() {
    super.initState();
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
              _buildWidget(context),
               Center(child: CircularProgressIndicator(color: color5,)),
            ],
          );
        }
        return _buildWidget(context);
      }),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return SafeArea(
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
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: HexColor("#000000").withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        color: HexColor(
                                            BranchesExtension.getColorForBranch(
                                                  paymentPreview?.lessonName ??
                                                      "Ders bulunamadı",
                                                ) ??
                                                DEFAULT_LESSON_COLOR),
                                        borderRadius: BorderRadius.circular(8),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "₺${paymentPreview?.price ?? ""}",
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
                                  Navigator.pushNamed(context, '/makePayment',
                                      arguments: paymentPreview);
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
        ],
      ),
    );
  }
}
