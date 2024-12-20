import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget WhiteAppBar(String text,
    {VoidCallback? onTap, bool canGoBack = true}) {
  return AppBar(
    forceMaterialTransparency: true,
    scrolledUnderElevation: 0.0,
    centerTitle: false,
    elevation: 10,
    leading: canGoBack
        ? IconButton(
            onPressed: onTap ?? () => Get.back(),
            icon:  Icon(
              Icons.arrow_back_ios,
              color: color1,
            ),
          )
        : null,
    backgroundColor: Colors.white,
    title: Column(
      children: [
        Text(
          text,
          style: styleBlack16Bold,
        ),
      ],
    ),
  );
}
