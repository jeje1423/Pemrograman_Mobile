import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'widgets/app_theme.dart';

void main() {
  runApp(const FlutterNavigationDemo());
}

class FlutterNavigationDemo extends StatelessWidget {
  const FlutterNavigationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      theme: appTheme, // pastikan nama ini sama dengan di app_theme.dart
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
