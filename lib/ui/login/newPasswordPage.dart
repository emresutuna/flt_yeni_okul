import 'package:flutter/material.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/YOText.dart';
import 'package:yeni_okul/widgets/YoHexText.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
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
                text: "Yeni Şifre",
                size: 20,
                fontWeight: FontWeight.bold,
                color: "#1A1348",
              ),
              const SizedBox(
                height: 32,
              ),
              const YoHexText(
                text:
                "Yeni şifreni tanımlayabilirsin",
                size: 14,
                fontWeight: FontWeight.w500,
                color: "#1A1348",
              ),
              const SizedBox(height: 32),
              TextBoxIcon(
                  icon: Icons.lock_outlined,
                  inputType: TextInputType.number,
                  obscure: true,
                  label: 'Yeni Şifre',
                  hint: 'Yeni Şifrenizi girin',
                  errorText: 'Bu alan zorunludur!',
                  onSaved: (String value) {}),
              const SizedBox(height: 16),
              TextBoxIcon(
                  icon: Icons.lock_outlined,
                  inputType: TextInputType.number,
                  obscure: true,
                  label: 'Yeni Şifre Tekrar',
                  hint: 'Yeni Şifrenizin Tekrarını girin',
                  errorText: 'Bu alan zorunludur!',
                  onSaved: (String value) {}),
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

                    },
                    child: const YoText(
                      text: "Tamam",
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
