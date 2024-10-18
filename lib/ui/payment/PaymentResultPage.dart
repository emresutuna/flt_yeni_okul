import 'package:flutter/material.dart';


import '../../main.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/SecondaryButton.dart';

class PaymentResultPage extends StatefulWidget {
  const PaymentResultPage({super.key});

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          PaymentResultPageWidget(
            isSuccess: false,
            title: "Ödeme İşlemi Başarısız",
            message: "Ödeme işleminizi tamamlayamadık, lütfen tekrar deneyin.",
            primaryButtonText: "Anasayfaya Dön",
            secondaryButtonText: "Ders Programı",
            onPrimaryButtonPress: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "")),
                (Route<dynamic> route) => false,
              );
            },
            onSecondaryButtonPress: () {
              Navigator.of(context).pushReplacementNamed('/timeSheetPage');
            },
          )
        ],
      )),
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
    return Scaffold(
      body: SafeArea(
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
                width: double.maxFinite,
                child: PrimaryButton(
                  text: primaryButtonText,
                  onPress: onPrimaryButtonPress,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
              child: SizedBox(
                width: double.maxFinite,
                child: SecondaryButton(
                  text: secondaryButtonText,
                  onPress: onSecondaryButtonPress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
