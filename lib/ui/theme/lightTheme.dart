// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFF987D9A),
    scaffoldBackgroundColor: const Color(0xFFE7E7E7),
    iconTheme: const IconThemeData(color: Colors.red),
    shadowColor: Colors.black.withOpacity(0.08),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );
}
