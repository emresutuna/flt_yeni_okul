import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';
import 'YOText.dart';
import 'YoHexText.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: colorGreen),
      child: Text(text),
    );
  }
}

class YoButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  final String? borderColor;
  final String text;
  final String? backgroundColor;
  final String? textColor;
  final VoidCallback onPress;

  const YoButton(
      {super.key,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.borderColor,
      required this.text,
      required this.backgroundColor,
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
              borderRadius: BorderRadius.circular(borderRadius??10),
            ),
            backgroundColor:
                backgroundColor != null ? greenButton : Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0,
            side: borderColor != null
                ? BorderSide(
                    width: 2.0,
                    color: HexColor("#" "$borderColor"),
                  )
                : BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            textStyle: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => onPress.call(),
          child: YoHexText(
            size: 14,
            text: text,
            fontWeight: FontWeight.bold,
            color: "#" "$textColor",
          )),
    );
  }
}

class OutlinedCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OutlinedCustomButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(width: 5.0, color: colorGreen),
      ),
      child: YoText(
        text: text,
      ),
    );
  }
}
