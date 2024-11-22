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
extension CustomRadius on num {
  BorderRadius get borderRadius => BorderRadius.circular(toDouble());
  Radius get circularRadius => Radius.circular(toDouble());
}
extension EdgeInsetsExtension on num {
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get topPadding => EdgeInsets.only(top: toDouble());
  EdgeInsets get bottomPadding => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get leftPadding => EdgeInsets.only(left: toDouble());
  EdgeInsets get rightPadding => EdgeInsets.only(right: toDouble());
  EdgeInsets get topLeftPadding => EdgeInsets.only(top:toDouble(),left: toDouble());
  EdgeInsets get topRightPadding => EdgeInsets.only(top:toDouble(),right: toDouble());
}