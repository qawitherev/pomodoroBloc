import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDark = false;

  get themeMode => _themeMode;
  get isDark => _isDark;

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _isDark = true;
      notifyListeners();
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      _isDark = false;
      notifyListeners();
    }
  }
}