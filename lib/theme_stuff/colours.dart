import 'dart:ui';

import 'package:flutter/material.dart';

class Colours {
  static const swatch = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6), // The primary color
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  static const PRIMARY_COLOR = Color(0xFF7E57C2);
  static const PRIMARY_DARK_COLOR = Color(0xFF4527A0);
  static const PRIMARY_SWATCH = MaterialColor(0xFF7E57C2, swatch);
  static const PRIMARY_DARK_SWATCH = MaterialColor(0xFF4527A0, swatch);



}