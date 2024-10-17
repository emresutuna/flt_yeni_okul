import 'package:flutter/material.dart';
import 'package:yeni_okul/util/YOColors.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;

  const InfoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.info_outline, // Default icon if not provided
    this.backgroundColor = const Color(0xFFEFF8FE), // Light blue background
    this.borderColor = const Color(0xFF007AFF), // Default border color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: borderColor,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: styleBlack14Bold,
                ),
                const SizedBox(height: 4),
                Text(description, style: styleBlack12Regular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
