import 'package:flutter/material.dart';

ThemeData temaClaro = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    onSurface: Colors.black,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black, // button text color
    ),
  ),
  fontFamily: 'SFPro',
);
