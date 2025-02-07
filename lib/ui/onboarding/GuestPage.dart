import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/widgets/SecondaryButton.dart';
import 'package:flutter/material.dart';

import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/FirebaseAnalyticsManager.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.toHeight,
                Text(
                  "Hemen Başlayalım",
                  textAlign: TextAlign.center,
                  style: styleBlack18Bold,
                ),
                16.toHeight,
                Text(
                  "baykurs’un başarı dolu dünyasını keşfetmek için misafir olarak giriş yapabilir ya da kayıt olabilirsin. Hesabın varsa hemen giriş yapabilirsin.",
                  textAlign: TextAlign.start,
                  style: styleBlack14Regular,
                ),
                64.toHeight,
                PrimaryButton(
                  text: "Kayıt Ol",
                  onPress: () {
                    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.user_register);
                    Navigator.pushReplacementNamed(context, '/registerPage');
                  },
                ),
                16.toHeight,
                SecondaryButton(
                  text: "Giriş Yap",
                  onPress: () {
                    FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.user_login);
                    Navigator.pushReplacementNamed(context, '/loginPage');
                  },
                ),
                24.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.guest_click);
                        Navigator.pushReplacementNamed(context, '/mainPage');
                      },
                      child: Text(
                        "Misafir Olarak Giriş Yap",
                        style: styleBlack16Regular.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: color5,
                            color: color5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
