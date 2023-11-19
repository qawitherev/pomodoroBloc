import 'package:flutter/material.dart';
import 'package:pomodoro/theme_stuff/color_themes.dart';
import 'package:pomodoro/utils/our_constants.dart';
import 'package:pomodoro/utils/shared_prefs.dart';

class SettingsProvider extends ChangeNotifier {
  String _lang = "en";
  bool _isDark = false;
  ThemeData _lightTheme = defaultTheme;
  ThemeData _darkTheme = defaultDarkTheme;
  ThemeMode _themeMode = ThemeMode.light;

  get lang => _lang;
  get isDark => _isDark;
  get lightTheme => _lightTheme;
  get darkTheme => _darkTheme;
  get themeMode => _themeMode;

  SettingsProvider() {
    initSettings();
  }

  void toggleTheme() {
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

  void initSettings() {
    getSavedThemeMode();
  }

  void toggleSwitch(bool value) {
    _isDark = value;
    notifyListeners();
  }

  void setLang(String lang) {}

  void setThemeColor(ThemeData defaultTheme) {}

  void getSavedThemeMode() async {
    final isSaved = await SharedPrefs.isExist(ThemeConstants.isDarkKey);
    if (!isSaved) {
      _themeMode = ThemeMode.light;
      _isDark = false;
    } else {
      final isDark = await SharedPrefs.readSharedPrefs(ThemeConstants.isDarkKey, SharedPrefsType.boolean);
      if (!isDark) {
        _themeMode = ThemeMode.light;
        _isDark = false;
        notifyListeners();
      } else {
        _themeMode = ThemeMode.dark;
        _isDark = true;
        notifyListeners();
      }
    }
  }
}

/*
settings
1. theme mode
2. language
3. color? -> disputable
4. about
 */