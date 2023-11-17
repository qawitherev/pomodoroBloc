import 'dart:ui';

import 'package:flutter/material.dart';

class Settings {
  bool isDark;
  String language;
  ThemeData? themeColor;

  Settings({
    this.isDark = true,
    this.language = "en",
    this.themeColor,
});
}