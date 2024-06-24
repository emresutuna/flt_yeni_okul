import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/YOText.dart';
import 'package:yeni_okul/widgets/YoHexText.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(100, 141, 153, 202),
              Color.fromARGB(100, 141, 153, 202),
              Color.fromARGB(90, 141, 153, 202),
              Color.fromARGB(53, 141, 153, 202),
              Color.fromARGB(34, 141, 153, 202),
              Color.fromARGB(0, 141, 153, 202),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 32, right: 0, bottom: 0),
                child: IconButton(
                  color: HexColor("#1A1348"),
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
              const YoHexText(
                text: "Şifremi Unuttum",
                size: 20,
                fontWeight: FontWeight.bold,
                color: "#1A1348",
              ),
              const SizedBox(
                height: 32,
              ),
              const YoHexText(
                text:
                    "Kayıt esnasında verilmiş olan e-mail adresinizi yazınız.",
                size: 14,
                fontWeight: FontWeight.w500,
                color: "#1A1348",
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
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: HexColor("#1A1348"),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 18),
                      textStyle: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/emailOtp');
                    },
                    child: const YoText(
                      text: "Şifremi Sıfırla",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
