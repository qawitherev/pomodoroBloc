//default [light mode] theme
import 'package:flutter/material.dart';
import 'package:pomodoro/theme_stuff/colours.dart';


ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colours.PRIMARY_COLOR,
  primarySwatch: Colours.PRIMARY_SWATCH,
  useMaterial3: true,
  textTheme: TextTheme(

  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colours.PRIMARY_DARK_COLOR,
  primarySwatch: Colours.PRIMARY_DARK_SWATCH,
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Colours.PRIMARY_DARK_COLOR,
  // ),
  useMaterial3: true
);