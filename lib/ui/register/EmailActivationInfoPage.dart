import 'package:baykurs/util/all_extension.dart';
import 'package:flutter/material.dart';

import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';

class EmailActivationInfoPage extends StatelessWidget {
  const EmailActivationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'assets/baykurs_main_logo.png',
                    height: MediaQuery.of(context).size.height / 7.5,
                  ),
                  16.toHeight,
                  Text(
                    "Mail adresinize gelen aktivasyon kodunu lütfen onaylayın. Onayladıysanız tamam diyip devam edebilirsin..",
                    textAlign: TextAlign.center,
                    style: styleBlack14Regular,
                  ),
                  24.toHeight,
                  PrimaryButton(
                    text: "Tamam",
                    onPress: () {
                      Navigator.pushReplacementNamed(context, '/mainPage');

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
