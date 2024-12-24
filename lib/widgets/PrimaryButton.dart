import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

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
          onPressed: onPress,
          child: Text(
            text,
            style: styleBlack14Bold.copyWith(color: Colors.white),
          )),
    );
  }
}
