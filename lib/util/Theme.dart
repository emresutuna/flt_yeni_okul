import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color color1 = Color(0xFF222831); // Ana yazı rengi
const Color color2 = Colors.grey; // Yardımcı gri tonu
const Color color3 = Colors.green; // Vurgu yeşil tonu
const Color colorLightGray = Color(0xFFF5F5F5); // Arkaplan gri tonu

TextTheme customTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 22, fontWeight: FontWeight.bold, color: color1),
  displayMedium: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.bold, color: color1),
  displaySmall: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.bold, color: color1),

  bodyLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.normal, color: color1),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.normal, color: color1),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.normal, color: color2),

  titleLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.bold, color: color1),
  titleMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.bold, color: color1),
  titleSmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.normal, color: color1),

  labelLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  labelMedium: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
  labelSmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
);

final TextStyle styleGreen18Bold = GoogleFonts.poppins(
    fontSize: 18, fontWeight: FontWeight.bold, color: color3);

final TextStyle styleWhite12Bold = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);

final TextStyle styleWhite14Regular = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  textTheme: customTextTheme,
  fontFamily: GoogleFonts.poppins().fontFamily,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: color5,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: color1,
    ),
    iconTheme: const IconThemeData(color: color1),
  ),
);
