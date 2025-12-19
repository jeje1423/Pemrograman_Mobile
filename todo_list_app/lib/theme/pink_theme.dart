import 'package:flutter/material.dart';

class PinkTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    scaffoldBackgroundColor: Colors.pink.shade50,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      primary: Colors.pink,
      secondary: Colors.pinkAccent,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.pink.shade400,
      foregroundColor: Colors.white,
      elevation: 4,
      centerTitle: true,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink.shade400,
      elevation: 5,
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.pink),
    ),
  );
}
