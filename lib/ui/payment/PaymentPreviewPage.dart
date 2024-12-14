import 'package:baykurs/ui/payment/bloc/PaymentPreviewBloc.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewEvent.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:baykurs/widgets/GreenPrimaryButton.dart';
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
  CourseDetailData? courseDetail;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context) != null) {
        setState(() {
          courseDetail =
              ModalRoute.of(context)!.settings.arguments as CourseDetailData;
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
              const Center(child: CircularProgressIndicator()),
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 24),
            child: Row(
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back_ios),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text("Ders Satın Al", style: styleBlack16Bold),
              ],
            ),
          ),
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Satın Aldığınız Ders',
                              style: styleBlack16Bold,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Hemen Kayıt olarak eşsiz deneyimimize katılabilirsin ',
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
                                      'YKS HAZIRLIK – MATEMATİK – Fonksiyon 8 – Karma Soru Çözümleriyle Genel Tekrar',
                                      style: styleBlack14Bold,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: HexColor(
                                            BranchesExtension.getColorForBranch(
                                                  courseDetail?.lesson?.name ??
                                                      courseDetail
                                                          ?.lessonName ??
                                                      "Ders bulunamadı",
                                                ) ??
                                                "Varsayılan renk kodu"),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        courseDetail!.lesson?.name ??
                                            courseDetail!.lessonName ??
                                            "Ders bulunamadı",
                                        style: styleWhite12Bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      courseDetail!.school?.name ??
                                          courseDetail!.schoolName ??
                                          "Kurum ismi bulunamadı",
                                      style: styleBlack12Bold,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      courseDetail!.formattedDateRange ?? "",
                                      style: styleBlack12Regular,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      courseDetail!.classroom ?? "-",
                                      style: styleBlack12Regular,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${courseDetail!.price} ₺",
                                          style: styleGreen18Bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 50,
                              width: double.maxFinite,
                              child: GreenPrimaryButton(
                                text: "Devam Et",
                                onPress: () {
                                  context.read<PaymentPreviewBloc>().add(
                                        BuyCourse(
                                            courseId: courseDetail!.id ?? 0),
                                      );
                                },
                              ),
                            ),
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
