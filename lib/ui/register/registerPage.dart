import 'package:flutter/material.dart';

import '../../util/SimpleStream.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/YOText.dart';
import '../login/UserRole.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserRole? userRole;
  bool privacyPolicy = false;
  SimpleStream<bool> checkStream = SimpleStream<bool>();

  bool get check => checkStream.current ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 16, right: 0, bottom: 0),
                child: Row(
                  children: [
                    IconButton(
                      color: color1,
                      padding: EdgeInsets.zero,
                      iconSize: 26,
                      alignment: Alignment.centerLeft,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    YoText(
                      text: "Kayıt Ol",
                      size: 18,
                      fontWeight: FontWeight.bold,
                      color: color1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              YoText(
                text:
                    "Hemen Kayıt olarak eşsiz deneyimimize katılabilirsin . Loem ipsum dolar ko sit amet ko",
                size: 12,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                color: color2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color1,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    hintText: 'Ad',
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color1,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    hintText: 'Soyad',
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color1,
                  onChanged: (value) {},
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color1,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    hintText: 'Telefon No',
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color1,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    hintText: 'Şifre',
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
              ),
              ListTileTheme(
                horizontalTitleGap: 0.0,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  tristate: false,
                  activeColor: color5,
                  side: BorderSide(width: 1, color: color5),
                  title: const YoText(
                    text:
                        "By signing up you agree to our Terms & Conditions and Privacy Policy",
                    textAlign: TextAlign.start,
                  ),

                  checkColor: Colors.white,

                  value: privacyPolicy,
                  onChanged: (newValue) {
                    setState(() {
                      privacyPolicy = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              ListTileTheme(
                horizontalTitleGap: 0.0,
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  tristate: false,
                  activeColor: color5,
                  side: BorderSide(width: 1, color: color5),
                  title: const YoText(
                    text:
                        "By signing up you agree to our Terms & Conditions and Privacy Policy",
                    textAlign: TextAlign.start,
                  ),
                  checkColor: Colors.white,
                  value: checkStream.current ?? false,
                  onChanged: (newValue) {
                    setState(() {
                      checkStream.update(newValue ?? false);
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              PrimaryButton(text: "Kayıt Ol", onPress: () {})
            ],
          ),
        ),
      ),
    );
  }
}
