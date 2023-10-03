// ignore_for_file: file_names

import 'package:flutter/material.dart';

ThemeData darkTheme(MaterialColor primaryColor, ThemeData theme) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color.fromARGB(255, 44, 44, 44),
    iconTheme: IconThemeData(color: theme.hintColor.withOpacity(.3)),
    shadowColor: Colors.white.withOpacity(0.08),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black54,
      unselectedIconTheme: IconThemeData(color: Colors.white),
    ),
    cardColor: Colors.black54,
  );
}
