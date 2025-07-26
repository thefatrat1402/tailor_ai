import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Measurements")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: data.entries
              .map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "${entry.key}: ${entry.value}",
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
