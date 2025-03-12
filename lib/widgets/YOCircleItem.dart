import 'package:flutter/material.dart';
import 'YOText.dart';

class YoCircleItem extends StatelessWidget {
  final String? text;
  final String? asset;
  final Color circleColor;
  final Color? textColor;

  const YoCircleItem(
      {super.key,
      this.text,
      this.asset,
      required this.circleColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        height: 70,
        width: 70,
        // Border width
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: circleColor,
        ),
        child: Center(
          child: text != null
              ? YoText(
                  text: "08",
                  size: 24,
                  fontWeight: FontWeight.w700,
                  color: textColor ?? Colors.black,
                )
              : Image.asset(asset ?? "assets/placeholder.png"),
        ));
  }
}
