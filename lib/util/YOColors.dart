import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HexColor.dart';

Color colorGreen = HexColor("#4DC591");
Color colorPurple = HexColor("#9BA1FF");
Color colorOrange = HexColor("#FF7648");
Color colorBlack = HexColor("#191B32");
Color colorGray = HexColor("#9295A3");
Color greenButton = HexColor("#05A95C");
Color colorWhite = HexColor("#FFFFFF");

Color color1 = HexColor("#222831");
Color color2 = HexColor("#393E46");
Color color3 = HexColor("#7DCB70");
Color color4 = HexColor("#F6F6F6");
Color color5 = HexColor("#F4951E");
Color color6 = HexColor("#FF3A44");

Color renkMatematik = HexColor("#4A90E2");
Color renkTurkce = HexColor("#FFA500");
Color renkFenBilgisi = HexColor("#6DD6A7");
Color renkTarih = HexColor("#E94E77");
Color renkCografya = HexColor("#FFD700");
Color renkKimya = HexColor("#8E44AD");
Color renkBiyoloji = HexColor("#F39C12");
Color renkFizik = HexColor("#FF6F61");

TextStyle styleBlack10Regular = GoogleFonts.notoSans(
    fontSize: 10, fontWeight: FontWeight.normal, color: color1);
TextStyle styleBlack12Regular = GoogleFonts.notoSans(
    fontSize: 12, fontWeight: FontWeight.normal, color: color1);
TextStyle styleBlack14Regular = GoogleFonts.notoSans(
    fontSize: 14, fontWeight: FontWeight.normal, color: color1);
TextStyle styleBlack16Regular = GoogleFonts.notoSans(
    fontSize: 16, fontWeight: FontWeight.normal, color: color1);
TextStyle styleBlack18Regular = GoogleFonts.notoSans(
    fontSize: 18, fontWeight: FontWeight.normal, color: color1);
TextStyle styleBlack10Bold = GoogleFonts.notoSans(
    fontSize: 10, fontWeight: FontWeight.bold, color: color1);

TextStyle styleBlack12Bold = GoogleFonts.notoSans(
    fontSize: 12, fontWeight: FontWeight.bold, color: color1);
TextStyle styleGray12Bold = GoogleFonts.notoSans(
    fontSize: 12, fontWeight: FontWeight.bold, color: color2);
TextStyle styleBlack14Bold = GoogleFonts.notoSans(
    fontSize: 14, fontWeight: FontWeight.bold, color: color1);
TextStyle styleBlack16Bold = GoogleFonts.notoSans(
    fontSize: 16, fontWeight: FontWeight.bold, color: color1);
TextStyle styleBlack18Bold = GoogleFonts.notoSans(
    fontSize: 18, fontWeight: FontWeight.bold, color: color1);

TextStyle styleWhite12Bold = GoogleFonts.notoSans(
    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle styleWhite14Bold = GoogleFonts.notoSans(
    fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle styleWhite16Bold = GoogleFonts.notoSans(
    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle styleWhite18Bold = GoogleFonts.notoSans(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle styleWhite12Regular = GoogleFonts.notoSans(
    fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white);
TextStyle styleWhite14Regular = GoogleFonts.notoSans(
    fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);
TextStyle styleWhite16Regular = GoogleFonts.notoSans(
    fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white);

TextStyle styleGreen18Bold = GoogleFonts.notoSans(
    fontSize: 18, fontWeight: FontWeight.bold, color: color3);

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
