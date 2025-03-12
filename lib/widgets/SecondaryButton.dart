import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/YOColors.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const SecondaryButton({super.key, required this.text, required this.onPress});

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
            backgroundColor: Colors.transparent,
            elevation: 0,
            side: BorderSide(
              width: 1.0,
              color: color5, // Border color
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            textStyle: GoogleFonts.notoSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () => onPress.call(),
          child: Text(text,style: styleBlack14Bold.copyWith(color: color5),)
      ),
    );
  }
}
