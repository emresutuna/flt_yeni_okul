import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/YOColors.dart';

class TertiaryButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final String text;
  final String? textColor;
  final VoidCallback onPress;

  const TertiaryButton(
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
            backgroundColor: color3,
            elevation: 0,
            textStyle: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => onPress.call(),
          child: Text(
            text,
            style: styleWhite14Bold,
          )),
    );
  }
}
