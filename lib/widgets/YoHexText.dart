import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/HexColor.dart';
class YoHexText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final String? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  final bool? isUnderLine;
  final TextAlign? textAlign;

  const YoHexText(
      {super.key,
      required this.text,
      this.size = 14,
      this.fontWeight = FontWeight.w500,
      this.color = "#00000",
      this.wordSpacing,
      this.onClick,
      this.isUnderLine = false,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(text,
              textAlign: textAlign ?? TextAlign.start,
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                decoration: isUnderLine! == false
                    ? TextDecoration.none
                    : TextDecoration.underline,
                fontSize: size,
                fontWeight: fontWeight,
                color: HexColor(color!),
                wordSpacing: wordSpacing,
              )))
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(text,
                  textAlign: textAlign ?? TextAlign.start,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    decoration: isUnderLine! == false
                        ? TextDecoration.none
                        : TextDecoration.underline,
                    fontSize: size,
                    fontWeight: fontWeight,
                    color: HexColor(color!),
                    wordSpacing: wordSpacing,
                  ))),
            ),
    );
  }
}
