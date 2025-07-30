import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = ModalRoute.of(context)?.settings.arguments as double? ?? 0.0;
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Text(
          height > 0 ? 'Estimated Height: ${height.toStringAsFixed(2)} meters' : 'No height detected.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
