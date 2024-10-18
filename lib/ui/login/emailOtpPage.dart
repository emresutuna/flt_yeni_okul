import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../util/HexColor.dart';
import '../../widgets/YOText.dart';
import '../../widgets/YoHexText.dart';

class EmailOtpPage extends StatefulWidget {
  const EmailOtpPage({super.key});

  @override
  State<EmailOtpPage> createState() => _EmailOtpPageState();
}

class _EmailOtpPageState extends State<EmailOtpPage> {
  OtpFieldController otpController = OtpFieldController();

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
                    otpController.clear();
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const YoHexText(
                text: "Aktivasyon Kodu",
                size: 20,
                fontWeight: FontWeight.bold,
                color: "#1A1348",
              ),
              const SizedBox(
                height: 32,
              ),
              const YoHexText(
                text:
                    "E-mail adresinize gelen 6 haneli aktivasyon kodunu girin.",
                size: 14,
                fontWeight: FontWeight.w500,
                color: "#1A1348",
              ),
              const SizedBox(height: 32),
              OTPTextField(
                  controller: otpController,
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 45,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#1A1348")),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                  }),
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
                      Navigator.pushNamed(context, '/newPasswordPage');
                    },
                    child: const YoText(
                      text: "Devam Et",
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
