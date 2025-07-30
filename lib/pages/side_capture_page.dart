import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import 'result_page.dart';

class SideCapturePage extends StatefulWidget {
  final String height;
  final File frontImage;

  const SideCapturePage(
      {super.key, required this.height, required this.frontImage});

  @override
  State<SideCapturePage> createState() => _SideCapturePageState();
}

class _SideCapturePageState extends State<SideCapturePage> {
  File? _sideImage;

  Future<void> _takePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _sideImage = File(pickedFile.path));
    }
  }

  Future<void> _submitData() async {
    final result = await ApiService.sendMeasurementData(
        widget.frontImage, _sideImage!, widget.height);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultPage(data: result)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset('assets/side.jpg',
                  fit: BoxFit.contain,
                  alignment: Alignment.center, 
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Column(
              children: const [
                Text(
                  "Hit this pose.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: _sideImage == null
                ? IconButton(
                    icon: const Icon(Icons.add_circle,
                        size: 80, color: Colors.white),
                    onPressed: _takePicture,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(_sideImage!, height: 300),
                      const SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: _submitData,
                          child: const Text("Submit to API"))
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
