import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle headline1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
  );

  static TextStyle subtitle1 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  );

  static TextStyle bodyText1 = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
