import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CapturePage extends StatefulWidget {
  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  static const platform = MethodChannel('com.example.arheight/height');
  bool _loading = false;
  String _instruction = "Tap on the person's head";
  int _tapCount = 0;

  Future<void> _startARHeightEstimation() async {
    setState(() {
      _loading = true;
      _instruction = "Tap on the person's head";
      _tapCount = 0;
    });
    try {
      final double height = await platform.invokeMethod('startHeightEstimation');
      Navigator.pushNamed(context, '/result', arguments: height);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to estimate height")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  void _resetTaps() {
    setState(() {
      _instruction = "Tap on the person's head";
      _tapCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture Video')),
      body: Center(
        child: _loading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(_instruction),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _resetTaps,
                    child: Text("Reset Taps"),
                  )
                ],
              )
            : ElevatedButton(
                onPressed: _startARHeightEstimation,
                child: Text('Start AR Video Scan'),
              ),
      ),
    );
  }
}
