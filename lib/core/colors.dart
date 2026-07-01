import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF26B71B); // The main green color
  static const Color primaryLight = Color(0xFFD6F619); // The light green in gradients
  static const Color background = Colors.white;
  static const Color textMain = Colors.black87;
  static const Color textSecondary = Colors.grey;
  static const Color cardBackground = Color(0xFFF5F5F5);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
