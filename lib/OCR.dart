import 'dart:io';

import 'package:cancer2/Screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


class VisionOCRPage extends StatefulWidget {
  const VisionOCRPage({super.key});

  @override
  State<VisionOCRPage> createState() => _VisionOCRPageState();
}

class _VisionOCRPageState extends State<VisionOCRPage> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String _recognizedText = 'No text recognized yet.';
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
      await _performOCR(_imageFile!);
    }
  }

  Future<void> _performOCR(File imageFile) async {
    setState(() => _isLoading = true);
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText result = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();

    if (!mounted) return;

    setState(() {
      _recognizedText = result.text;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff031e40),
      appBar: AppBar(
        backgroundColor: Color(0xff031e40),
        title: const Text('OCR', style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
            icon: Icon(Icons.arrow_back, color: Colors.white,)),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: _imageFile == null
                        ? Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0)
                          )
                        ],
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_a_photo_rounded, size: 48, color: Colors.black,),
                            SizedBox(height: 8),
                            Text('Tap to select an image' ,style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        _imageFile!,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Recognized Text:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:  Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(4, 4)
                          )
                        ],
                      ),
                      height: 300,
                      child: SelectableText(
                        _recognizedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),

    );
  }
}
