import 'dart:io';

import 'package:baykurs/repository/user_repository.dart';
import 'package:baykurs/ui/payment/bloc/PaymentPreviewState.dart';
import 'package:baykurs/ui/payment/makePayment/PaymentBillPage.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillBloc.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/bloc/PaymentBillState.dart';
import 'package:baykurs/ui/payment/makePayment/paymentBill/model/PaymentBillResponse.dart';
import 'package:baykurs/ui/payment/model/PaymentPreview.dart';
import 'package:baykurs/util/all_extension.dart';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:baykurs/util/LessonExtension.dart';
import 'package:baykurs/widgets/GreenPrimaryButton.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/payment_repository.dart';
import '../../service/api_service.dart';
import '../../service/result_response.dart';
import '../../util/HexColor.dart';
import '../../util/PriceFormatter.dart';
import '../../util/YOColors.dart';
import '../course/model/course_type_enum.dart';
import 'PaymentResultPage.dart';
import 'PaymentWebView.dart';
import 'makePayment/paymentBill/bloc/PaymentBillEvent.dart';
import 'model/PaymentResponse.dart';

class PaymentPreviewPage extends StatefulWidget {
  const PaymentPreviewPage({super.key});

  @override
  State<PaymentPreviewPage> createState() => _PaymentPreviewPageState();
}

class _PaymentPreviewPageState extends State<PaymentPreviewPage> {
  PaymentPreview? paymentPreview;
  List<BillList> paymentBillList = [];
  BillList? defaultBill;
  bool _isDialogShowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<PaymentBillBloc>().add(FetchBills());
  }

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
        appBar: WhiteAppBar("Ders Satın Al"),
        body: BlocConsumer<PaymentBillBloc, PaymentBillState>(
          listener: (context, state) {
            if (state is PaymentPreviewSuccess) {
              _navigateToPaymentResult(context, true);
            } else if (state is PaymentPreviewError) {
              _navigateToPaymentResult(context, false);
            }
            if (state is PaymentBillStateError) {
              if (state.error == mailNotVerifiedFailure && !_isDialogShowing) {
                _isDialogShowing = true;

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Mail Adresini Onaylamadın"),
                    content: const Text(
                        "Özgün eğitim modeline ilk adımını atmak için mail adresini onaylamalısın."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _isDialogShowing = false;
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Tamam",
                          style: TextStyle(
                              color: color5, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (!_isDialogShowing) {
                _isDialogShowing = true;

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Hata"),
                    content: Text(state.error.toString()),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _isDialogShowing = false;
                          Navigator.of(context).pop();
                        },
                        child: const Text("Tamam"),
                      ),
                    ],
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is PaymentBillStateLoading) {
              return Stack(
                children: [
                  _buildWidget(context),
                  const GlobalFadeAnimation(),
                ],
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
          },
        ));
  }

  Future<ResultResponse<PaymentResponse>> postBuyCourse(
      int courseId, CourseTypeEnum courseType) async {
    try {
      final response = await APIService.instance.request(
          buyCourse(courseId, courseType), DioMethod.post,
          includeHeaders: true);

      Map<String, dynamic> body = response.data;

      if (response.statusCode == HttpStatus.ok && body['status'] == true) {
        PaymentResponse paymentResponse = PaymentResponse.fromJson(body);
        return ResultResponse.success(paymentResponse);
      } else {
        String message = body['error'] ?? body['message'] ?? 'Bir hata oluştu.';
        return ResultResponse.failure(message);
      }
    } catch (e) {
      print(e.toString());
      return ResultResponse.failure('Exception: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hata"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tamam"),
          )
        ],
      ),
    );
  }

  Widget _buildWidget(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
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
                                  onPress: () async {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                          child: CircularProgressIndicator()),
                                    );

                                    try {
                                      final result = await postBuyCourse(
                                        paymentPreview?.id ?? 0,
                                        paymentPreview?.courseType ??
                                            CourseTypeEnum.course,
                                      );

                                      Navigator.pop(context);

                                      if (result.data != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentWebView(
                                                    courseId:
                                                        paymentPreview?.id ??
                                                            0),
                                          ),
                                        );
                                      } else {
                                        // Hata mesajını API'den alıyoruz
                                        _showErrorDialog(
                                            result.error ?? 'Bir hata oluştu.');
                                      }
                                    } catch (e) {
                                      Navigator.pop(context);
                                      _showErrorDialog(
                                          "Beklenmeyen bir hata oluştu: $e");
                                    }
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
                          "Kayıtlı Fatura Adresi ",
                          style: styleBlack16Bold,
                        ),
                        IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, "/billList");
                          },
                          icon: Icon(Icons.edit_note, color: color5),
                        ),
                      ],
                    ),
                    8.toHeight,
                    Text(
                      defaultBill != null
                          ? "Yapacağınız işlemde varsayılan kayıtlı fatura adresiniz kullanılacaktır."
                          : "Kayıtlı fatura adresin bulunmuyor. Lütfen bir fatura adresi ekle.",
                      style: styleBlack14Regular,
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
