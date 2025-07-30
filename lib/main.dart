import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/capture_page.dart';
import 'pages/result_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR Height Estimator',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/capture': (context) => CapturePage(),
        '/result': (context) => ResultPage(),
      },
    );
  }
}
