import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    const primaryColor = Color(0xFF987D9A);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFE7E7E7),
      iconTheme: const IconThemeData(color: Colors.black),
      shadowColor: Colors.black.withOpacity(0.08),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    const primaryColor = Color(0xFF987D9A);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFE7E7E7),
      iconTheme: const IconThemeData(color: Colors.black),
      shadowColor: Colors.black.withOpacity(0.08),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }
}
