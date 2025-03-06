import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/SecondaryButton.dart';

class PaymentResultPage extends StatelessWidget {
  final bool isSuccess;

  const PaymentResultPage({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaymentResultPageWidget(
          isSuccess: isSuccess,
          title: isSuccess ? "Ödeme İşlemi Başarılı" : "Ödeme İşlemi Başarısız",
          message: isSuccess
              ? "Ödemenizi başarıyla tamamladık, teşekkür ederiz."
              : "Ödeme işleminizi tamamlayamadık, lütfen tekrar deneyin.",
          primaryButtonText: isSuccess ? "Ana Sayfaya Dön" : "Tekrar Dene",
          secondaryButtonText: isSuccess ? "Ders Programı" : "Ana Sayfaya Dön",
          onPrimaryButtonPress: () {
            if (isSuccess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: "",
                        )),
                (Route<dynamic> route) => false,
              );
            } else {
              Navigator.pop(context);
            }
          },
          onSecondaryButtonPress: () {
            if (isSuccess) {
              Navigator.of(context).pushReplacementNamed('/timeSheetPage');
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: "",
                        )),
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}

class PaymentResultPageWidget extends StatelessWidget {
  final bool isSuccess;
  final String title;
  final String message;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryButtonPress;
  final VoidCallback onSecondaryButtonPress;

  const PaymentResultPageWidget({
    super.key,
    required this.isSuccess,
    required this.title,
    required this.message,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryButtonPress,
    required this.onSecondaryButtonPress,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(isSuccess
                ? "assets/ic_success_payment.png"
                : "assets/ic_error_payment.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Center(
              child: Text(
                title,
                style: styleBlack16Bold,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Center(
              child: Text(
                message,
                style: styleBlack14Regular,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: SizedBox(
              width: double.maxFinite, // Ensure button has max width
              child: PrimaryButton(
                text: primaryButtonText,
                onPress: onPrimaryButtonPress,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: SizedBox(
              width: double.maxFinite, // Ensure button has max width
              child: SecondaryButton(
                text: secondaryButtonText,
                onPress: onSecondaryButtonPress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
