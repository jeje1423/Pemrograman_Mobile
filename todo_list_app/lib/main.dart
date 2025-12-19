import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme/pink_theme.dart';

void main() {
  runApp(const TodoPinkApp());
}

class TodoPinkApp extends StatelessWidget {
  const TodoPinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo Pink App",
      debugShowCheckedModeBanner: false,
      theme: PinkTheme.light,
      home: const HomePage(),
    );
  }
}
