import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/YOColors.dart';

import '../util/HexColor.dart';
import 'YoHexText.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const PrimaryButton({super.key, required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: color5,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            textStyle: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => onPress.call(),
          child: YoHexText(
            size: 14,
            text: text,
            fontWeight: FontWeight.w600,
            color: "#FFFFFF",
          )),
    );
  }
}
