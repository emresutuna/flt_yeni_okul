import 'package:baykurs/ui/forgotpassword/ForgotPasswordValidation.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/YOColors.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final ForgotPasswordValidation forgotPasswordValidation =
      Get.put(ForgotPasswordValidation());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    forgotPasswordValidation.emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 32, right: 0, bottom: 0),
                child: IconButton(
                  color: color2,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 32,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Şifremi Unuttum",
              style: styleBlack18Bold.copyWith(fontSize: 22),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Kayıt esnasında verilmiş olan e-mail adresinizi yazınız.",
              style: styleBlack14Regular,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: forgotPasswordValidation.emailController,
              cursorColor: color1,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: color2.withAlpha(75),
                  fontWeight: FontWeight.w400,
                ),
                labelStyle:
                    TextStyle(color: color1, fontWeight: FontWeight.bold),
                focusColor: color2,
                focusedBorder: const UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    text: "Şifremi Sıfırla",
                    onPress: () {
                      if(forgotPasswordValidation.loginValid()){
                        Get.snackbar(
                          "Başarılı",
                          "Mail Adresinize sıfırlama bağlantısı iletildi",
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      }

                    })),
          ],
        ),
      ),
    );
  }
}
