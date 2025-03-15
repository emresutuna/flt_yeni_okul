import 'package:flutter/material.dart';

import 'YOColors.dart';

Future<void> showMailDialog({
  required BuildContext context,
  String title="Mail Adresini Onaylamadın",
   String content="Özgün eğitim modeline ilk adımını atmak için mail adresini onaylamalısın.",
  String confirmText = 'Tamam',
  bool barrierDismissible = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(
          title,
          style: styleBlack14Bold,
        ),
        content: Text(
          content,
          style: styleBlack12Regular,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(dialogContext).pop();
            },
            child: Text(
              confirmText,
              style: styleBlack14Bold.copyWith(color: color5),
            ),
          ),
        ],
      );
    },
  );
}
