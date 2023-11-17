import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String _lang = "en";
  bool _isDark = false;
  Color _themeColor =

  void toggleTheme() {}

  void setLang(String lang) {}

  void setThemeColor() {}
}

/*
settings
1. theme mode
2. language
3. color? -> disputable
4. about
 */