import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFEF2A39);
  static const Color dark = Color(0xFF3C2F2F);
  static const Color grey = Color(0xFF6A6A6A);
  static const Color lightGrey = Color(0xFFF3F4F6);
  static const Color textGrey = Color(0xFF808080);
  static const Color white = Colors.white;
  static const Color green = Color(0xFF1CC019);
}

class AppTextStyle {
  static TextStyle lobster({double size = 16, Color color = AppColors.dark}) {
    return TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      letterSpacing: 1.5,
    );
  }

  static TextStyle poppins({
    double size = 14,
    Color color = AppColors.dark,
    FontWeight weight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }

  static TextStyle roboto({
    double size = 14,
    Color color = AppColors.dark,
    FontWeight weight = FontWeight.normal,
    double? height,
  }) {
    return TextStyle(
        fontSize: size, color: color, fontWeight: weight, height: height);
  }

  static TextStyle inter({
    double size = 14,
    Color color = AppColors.dark,
    FontWeight weight = FontWeight.normal,
  }) {
    return TextStyle(fontSize: size, color: color, fontWeight: weight);
  }
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.white,
    );
  }
}
