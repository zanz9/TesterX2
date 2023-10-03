// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData lightTheme(MaterialColor primaryColor, ThemeData theme) {
  return ThemeData(
    primaryColor: primaryColor,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 231, 231, 231),
    iconTheme: IconThemeData(color: theme.hintColor.withOpacity(.3)),
    shadowColor: Colors.black.withOpacity(0.08),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
  );
}
