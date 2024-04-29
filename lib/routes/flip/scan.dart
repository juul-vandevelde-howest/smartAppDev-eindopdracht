import 'dart:convert';
import 'dart:io';
import 'package:flip/routes/flip/add.dart';
import 'package:flip/routes/flip/decks.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  File? selectedMedia;
  final picker = ImagePicker();
  bool isProcessing = false;
  bool didntGoAsPlanned = false;

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
              const SnackBar(
                  content: Text(
            'No image selected.',
            textAlign: TextAlign.center,
          )));
        }
      },
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return Center(
        child: Text(
          didntGoAsPlanned
              ? "Something went wrong. Please try again."
              : "Take/pick an image to convert to a deck. (Note that this feature is experimental and may not work as expected.)",
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
      child: isProcessing
          ? const Column(
              children: [
                CircularProgressIndicator(
                  color: Color(0xFF133266),
                ),
                SizedBox(height: 20),
                Text(
                  'Hold on, we are processing the image.',
                  style: TextStyle(
                    color: Color(0xFF133266),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Image.file(
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
    return isProcessing
        ? const SizedBox(
            height: 0,
          )
        : Column(
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
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedMedia = null;
                  });
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero,
                  ),
                ),
                child: const Text(
                  'Change image',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF133266),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> _extractText(File file) async {
    setState(() {
      isProcessing = true;
    });
    final textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    textRecognizer.close();
    FirebaseAuth auth = FirebaseAuth.instance;
    String? idToken = await auth.currentUser?.getIdToken();
    var response = await http.post(
      Uri.parse('http://10.0.2.2:3000/pair'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "OCR_output": text,
      }),
    );
    try {
      var body = jsonDecode(response.body);
      Map<String, dynamic> bodyMap = jsonDecode(body);
      List<Map<String, String>> cards = List<Map<String, String>>.from(
          bodyMap['cards'].map((item) => Map<String, String>.from(
              item.map((key, value) => MapEntry(key, value ?? '')))));

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation1,
              Animation<double> animation2) {
            return Add(
              editCards: cards,
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      setState(() {
        selectedMedia = null;
        isProcessing = false;
        didntGoAsPlanned = true;
      });
    }
  }
}
