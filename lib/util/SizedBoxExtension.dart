import 'package:flutter/material.dart';
extension SizedBoxExtension on int {
  Widget get toHeight{
    return SizedBox(
      height: toDouble(),
    );
  }
}
extension SizedBoxExtensionWidth on int {
  Widget get toWidth{
    return SizedBox(
      width: toDouble(),
    );
  }
}