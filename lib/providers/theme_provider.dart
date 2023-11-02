import 'package:flutter/material.dart';
import 'package:pomodoro/utils/our_contants.dart';
import 'package:pomodoro/utils/shared_prefs.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDark = false;

  get themeMode => _themeMode;
  get isDark => _isDark;

  ThemeProvider() {
    getSavedTheme();
  }

  void toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _isDark = true;
      SharedPrefs.saveSharedPrefs(ThemeConstants.isDarkKey, SharedPrefsType.boolean, true);
      notifyListeners();
    } else if (_themeMode == ThemeMode.dark) {
      _themeMode = ThemeMode.light;
      _isDark = false;
      SharedPrefs.saveSharedPrefs(ThemeConstants.isDarkKey, SharedPrefsType.boolean, false);
      notifyListeners();
    }
  }

  void getSavedTheme() async {
    final isSaved = await SharedPrefs.isExist(ThemeConstants.isDarkKey);
    if (!isSaved) {
      _themeMode = ThemeMode.light;
    } else {
      final isDark = await SharedPrefs.readSharedPrefs(ThemeConstants.isDarkKey, SharedPrefsType.boolean);
      if (!isDark) {
        _themeMode = ThemeMode.light;
        notifyListeners();
      } else {
        _themeMode = ThemeMode.dark;
        notifyListeners();
      }
    }
  }
}