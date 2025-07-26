import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const TailorAIApp());
}

class TailorAIApp extends StatelessWidget {
  const TailorAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tailor AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WelcomePage(),
    );
  }
}
