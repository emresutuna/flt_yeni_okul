import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:get/get.dart';
import '../../util/YOColors.dart';


class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
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
            Padding(
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
            const SizedBox(
              height: 16,
            ),
            Text(
              "Şifremi Unuttum",
              style: styleBlack18Bold,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Kayıt esnasında verilmiş olan e-mail adresinizi yazınız.",
              style: styleBlack14Regular,
            ),
            const SizedBox(height: 32),
            TextBoxLabel(
              label: 'E-mail',
              hint: 'E-mailinizi girin',
              errorText: 'Bu alan zorunludur!',
              onSaved: (String value) {},
            ),
            const SizedBox(height: 32),
            SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    text: "Şifremi Sıfırla",
                    onPress: () {
                      Get.snackbar(
                        "Başarılı",
                        "Mail Adresinize sıfırlama bağlantısı iletildi",
                        colorText: Colors.white,
                        backgroundColor: Colors.green,
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
