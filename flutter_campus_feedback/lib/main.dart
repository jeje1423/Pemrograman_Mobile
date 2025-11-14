import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() {
  runApp(const CampusFeedbackApp());
}

class CampusFeedbackApp extends StatelessWidget {
  const CampusFeedbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Campus Feedback',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFCE4EC),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[400],
          elevation: 8,
          shadowColor: Colors.pink.withOpacity(0.5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.pink, width: 2),
          ),
        ),
        cardTheme: CardThemeData( // DIUBAH: CardTheme -> CardThemeData
          elevation: 6,
          shadowColor: Colors.pink.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const DashboardPage(),
    );
  }
}