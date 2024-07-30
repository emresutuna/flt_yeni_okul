import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'YoHexText.dart';

class SecondaryButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final String text;
  final String? textColor;
  final VoidCallback onPress;

  const SecondaryButton(
      {super.key,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.text,
      required this.textColor,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            side: BorderSide(
              width: 1.0,
              color: color5,
            ),
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
            color: "#FD275F",
          )),
    );
  }
}
