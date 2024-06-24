import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YoText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final double? wordSpacing;
  final VoidCallback? onClick;
  final bool? isUnderLine;
  final TextAlign textAlign;
  final bool hasEllipsize;

  const YoText(
      {super.key,
      required this.text,
      this.size = 14,
      this.fontWeight = FontWeight.w500,
      this.color = Colors.black,
      this.wordSpacing,
      this.onClick,
      this.isUnderLine = false,
      this.textAlign = TextAlign.center,
      this.hasEllipsize = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(text,
              textAlign: textAlign,
              overflow:
                  hasEllipsize ? TextOverflow.ellipsis : TextOverflow.visible,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                decoration: isUnderLine! == false
                    ? TextDecoration.none
                    : TextDecoration.underline,
                fontSize: size,
                fontWeight: fontWeight,
                color: color,
                wordSpacing: wordSpacing,
              )))
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(text,
                  textAlign: textAlign,
                  overflow: hasEllipsize
                      ? TextOverflow.ellipsis
                      : TextOverflow.visible,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    decoration: isUnderLine! == false
                        ? TextDecoration.none
                        : TextDecoration.underline,
                    fontSize: size,
                    fontWeight: fontWeight,
                    color: color,
                    wordSpacing: wordSpacing,
                  ))),
            ),
    );
  }
}
