import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.pink,
    primary: Colors.pink,
    secondary: Colors.pinkAccent,
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFFFF0F5), // soft pink
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
    elevation: 2,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.pink,
    unselectedItemColor: Colors.grey,
  ),
);
