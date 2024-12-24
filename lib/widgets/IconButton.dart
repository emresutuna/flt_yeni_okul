import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';

class BkIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;

  const BkIconButton({Key? key, required this.onPressed, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color5,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
            child: Icon(
          iconData,
          color: Colors.white,
          size: 28,
        )),
      ),
    );
  }
}
