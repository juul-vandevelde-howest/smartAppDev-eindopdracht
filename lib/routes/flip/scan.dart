import 'dart:io';
import 'package:flip/routes/flip/decks.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  File? selectedMedia;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 60,
            left: 40,
            right: 40,
            bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation1,
                            Animation<double> animation2) {
                          return const Decks();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const PhosphorIcon(
                    PhosphorIconsBold.x,
                    size: 32.0,
                    color: Color(0xFF133266),
                  ),
                ),
              ],
            ),
            _imageView(),
            _buttonView(),
          ],
        ),
      ),
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          selectedMedia = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text(
          "Take/pick an image for text recognition.",
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: double.infinity,
      ),
    );
  }

  Widget _buttonView() {
    if (selectedMedia == null) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF133266),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    PhosphorIconsBold.camera,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Take a photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF133266), width: 2),
            ),
            child: TextButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    PhosphorIconsBold.images,
                    color: Color(0xFF133266),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Upload from gallery',
                    style: TextStyle(
                      color: Color(0xFF133266),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF133266),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          _extractText(selectedMedia!);
        },
        child: const Text(
          'Convert to deck',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _extractText(File file) async {
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    print(text);
    // show loading animation while processing
  }
}
