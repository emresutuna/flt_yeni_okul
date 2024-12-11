import 'package:flutter/material.dart';

import '../util/YOColors.dart';

class InfoCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;

  const InfoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.info_outline,
    this.backgroundColor = const Color(0xFFEFF8FE),
    this.borderColor = const Color(0xFF007AFF),
  }) : super(key: key);

  @override
  State<InfoCardWidget> createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(color: widget.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              widget.icon,
              color: widget.borderColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: styleBlack14Bold,
                  ),
                  const SizedBox(height: 4),
                  Text(widget.description, style: styleBlack12Regular),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = false;
                });
              },
              child: Icon(
                Icons.close,
                color: widget.borderColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
