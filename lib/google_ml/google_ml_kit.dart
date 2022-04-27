import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class PictureScanner extends StatefulWidget {
  const PictureScanner({Key? key}) : super(key: key);

  @override
  State<PictureScanner> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  bool textScanning = false;

  XFile? imageFile;

  String? scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Google ML Vision"),
      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (textScanning) const CircularProgressIndicator(),
                    if (!textScanning && imageFile == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFile != null) Image.file(File(imageFile!.path)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                    ),
                                    Text(
                                      "Pick Image",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        scannedText ?? '',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      var pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    print("Recognizer");
    print(image.path);
    try{
      final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(File(image.path));
      final TextRecognizer textRecognizer = GoogleVision.instance.textRecognizer();
      final VisionText visionText = await textRecognizer.processImage(visionImage);
      await textRecognizer.close();
      scannedText = "";
      String? text = visionText.text;
      print(text);
      for (TextBlock block in visionText.blocks) {
        final Rect? boundingBox = block.boundingBox;
        final List<Offset> cornerPoints = block.cornerPoints;
        final String? text = block.text;
        final List<RecognizedLanguage> languages = block.recognizedLanguages;
        for (TextLine line in block.lines) {
          // Same getters as TextBlock
          scannedText = scannedText! + (line.text ?? '') + "\n";
          for (TextElement element in line.elements) {
            // Same getters as TextBlock
          }
        }
      }
      textScanning = false;
      setState(() {});
    }catch(e) {
      print("Error $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }
}