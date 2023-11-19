import 'package:flutter/material.dart';
import 'package:pomodoro/theme_stuff/color_themes.dart';
import 'package:pomodoro/utils/Misc.dart';
import 'package:pomodoro/utils/our_constants.dart';
import 'package:pomodoro/utils/shared_prefs.dart';

class SettingsProvider extends ChangeNotifier {
  Language _lang = Language.en;
  bool _isDark = false;
  ThemeData _lightTheme = blueTheme;
  ThemeData _darkTheme = blueDarkTheme;
  ThemeMode _themeMode = ThemeMode.light;

  get lang => _lang;

  get isDark => _isDark;

  get lightTheme => _lightTheme;

  get darkTheme => _darkTheme;

  get themeMode => _themeMode;

  SettingsProvider() {
    initSettings();
  }

  Future<bool> toggleTheme() async {
    _isDark = !_isDark;
    _themeMode = _isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    return await SharedPrefs.saveSharedPrefs(
        SettingsConstants.isDarkKey, SharedPrefsType.boolean, _isDark);
  }

  void initSettings() {
    getSavedThemeMode();
    getSavedLang();
    getSavedThemeColor();
  }

  Future<bool> setLang(Language lang) async {
    _lang = lang;
    notifyListeners();
    return await SharedPrefs.saveSharedPrefs(
        SettingsConstants.language, SharedPrefsType.string, (_lang.name));
  }

  void setThemeColor(ColorTheme colorTheme) async {
    switch (colorTheme) {
      case ColorTheme.defaultTheme:
        _lightTheme = defaultTheme;
        _darkTheme = defaultDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
      case ColorTheme.redTheme:
        _lightTheme = redTheme;
        _darkTheme = redDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
      case ColorTheme.greenTheme:
        _lightTheme = greenTheme;
        _darkTheme = greenDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
      case ColorTheme.blueTheme:
        _lightTheme = blueTheme;
        _darkTheme = blueDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
      case ColorTheme.orangeTheme:
        _lightTheme = orangeTheme;
        _darkTheme = orangeDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
      case ColorTheme.aquaTheme:
        _lightTheme = aquaTheme;
        _darkTheme = aquaDarkTheme;
        notifyListeners();
        await SharedPrefs.saveSharedPrefs(SettingsConstants.themeColor,
            SharedPrefsType.string, colorTheme.name);
        break;
    }
  }

  void getSavedThemeMode() async {
    final isSaved = await SharedPrefs.isExist(SettingsConstants.isDarkKey);
    if (!isSaved) {
      _themeMode = ThemeMode.light;
      _isDark = false;
    } else {
      final isDark = await SharedPrefs.readSharedPrefs(
          SettingsConstants.isDarkKey, SharedPrefsType.boolean);
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

  void getSavedLang() async {
    final isSaved = await SharedPrefs.isExist(SettingsConstants.language);
    if (!isSaved) {
      setLang(Language.en);
    } else {
      final savedLang = await SharedPrefs.readSharedPrefs(
          SettingsConstants.language, SharedPrefsType.string);
      _lang = Misc.stringToEnum(savedLang, Language.values);
      notifyListeners();
    }
  }

  void getSavedThemeColor() async {
    final isSaved = await SharedPrefs.isExist(SettingsConstants.themeColor);
    if (!isSaved) {
      setThemeColor(ColorTheme.defaultTheme);
    } else {
      final savedThemeColor = await SharedPrefs.readSharedPrefs(
          SettingsConstants.themeColor, SharedPrefsType.string);
      setThemeColor(Misc.stringToEnum(savedThemeColor, ColorTheme.values));
    }
  }
}

enum Language {
  en, //--> english
  ms, //--> malay
}

enum ColorTheme {
  defaultTheme,
  redTheme,
  greenTheme,
  blueTheme,
  orangeTheme,
  aquaTheme
}
/*
settings
1. theme mode
2. language
3. color? -> disputable
4. about
 */
