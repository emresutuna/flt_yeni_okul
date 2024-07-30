import 'package:flutter/material.dart';
import 'package:yeni_okul/util/YOColors.dart';

class CompanyListItem extends StatelessWidget {
  final String title;
  final String message;

  const CompanyListItem(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center, style: styleBlack16Bold),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center, style: styleBlack14Bold),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              width: 50,
              height: 50,
              child: Icon(
                Icons.error_outline,
                color: color6,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
