import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yeni_okul/util/SimpleStream.dart';

import '../util/YOColors.dart';
import 'YOText.dart';

yoCheckBox(final SimpleStream<bool> check) {
  ListTileTheme(
    horizontalTitleGap: 0.0,
    child: CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: color5,
      side: BorderSide(width: 1, color: color5),
      tristate: false,
      title: const YoText(
        text:
            "By signing up you agree to our Terms & Conditions and Privacy Policy",
        textAlign: TextAlign.start,
      ),
      checkColor: Colors.white,
      value: check.current?? false,
      onChanged: (newValue) {
        check.update(newValue ?? false);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    ),
  );
}
