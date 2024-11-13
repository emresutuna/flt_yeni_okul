import 'package:baykurs/util/SizedBoxExtension.dart';
import 'package:baykurs/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';

import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';

class UnLoginPage extends StatelessWidget {
  const UnLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/yeni_okul_logo_v2.png',
                    height: MediaQuery.of(context).size.height / 7.5,
                  ),
                  Text(
                    "Henüz giriş yapmadınız. Giriş veya Kayıt işlemi yaparak Profil bilgilerinize ulaşabilirsiniz.",
                    textAlign: TextAlign.center,
                    style: styleBlack14Regular,
                  ),
                  24.toHeight,
                  PrimaryButton(
                    text: "Giriş Yap",
                    onPress: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/loginPage");
                    },
                  ),
                  16.toHeight,
                  SecondaryButton(
                    text: 'Kayıt Ol',
                    onPress: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/registerPage");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
