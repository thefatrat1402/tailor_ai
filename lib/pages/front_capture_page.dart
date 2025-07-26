import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'side_capture_page.dart';

class FrontCapturePage extends StatefulWidget {
  final String height;

  const FrontCapturePage({super.key, required this.height});

  @override
  State<FrontCapturePage> createState() => _FrontCapturePageState();
}

class _FrontCapturePageState extends State<FrontCapturePage> {
  File? _frontImage;

  Future<void> _takePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _frontImage = File(pickedFile.path));
    }
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
              child: Image.asset('assets/front.jpg',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
              ),
            ),
          ),
          Center(
            child: _frontImage == null
                ? IconButton(
                    icon: const Icon(Icons.add_circle,
                        size: 80, color: Colors.white),
                    onPressed: _takePicture,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.file(_frontImage!, height: 300),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SideCapturePage(
                                      height: widget.height,
                                      frontImage: _frontImage!)));
                        },
                        child: const Text("Next"),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
