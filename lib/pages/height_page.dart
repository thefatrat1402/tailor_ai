import 'package:flutter/material.dart';
import 'front_capture_page.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({super.key});

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  final TextEditingController _controller = TextEditingController();

  void _continue() {
    if (_controller.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                FrontCapturePage(height: _controller.text.trim())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your height (in cm)',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "e.g. 170",
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white10,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: _continue, child: const Text("Next"))
            ],
          ),
        ),
      ),
    );
  }
}
