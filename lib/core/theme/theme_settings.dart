import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;
  ThemeMode get currentTheme => _currentTheme;

  ThemeSettings(bool isDark) {
    _currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentTheme == ThemeMode.light) {
      _currentTheme = ThemeMode.dark;
      prefs.setBool('isDark', true);
    } else {
      _currentTheme = ThemeMode.light;
      prefs.setBool('isDark', false);
    }
    notifyListeners();
  }
}
