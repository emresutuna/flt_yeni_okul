import 'dart:ui';
import 'package:flutter/material.dart';

import 'HexColor.dart';

Color colorGreen = HexColor("#4DC591");
Color colorPurple = HexColor("#9BA1FF");
Color colorOrange = HexColor("#FF7648");
Color colorBlack = HexColor("#191B32");
Color colorGray = HexColor("#9295A3");
Color greenButton = HexColor("#05A95C");
Color colorWhite = HexColor("#FFFFFF");



var gradient = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color.fromARGB(100, 141, 153, 202),
      Color.fromARGB(100, 141, 153, 202),
      Color.fromARGB(90, 141, 153, 202),
      Color.fromARGB(53, 141, 153, 202),
      Color.fromARGB(34, 141, 153, 202),
      Color.fromARGB(0, 141, 153, 202),
    ],
  ),
);
