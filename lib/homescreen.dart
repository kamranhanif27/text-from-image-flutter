import 'package:flutter/material.dart';
import 'package:image_processing/google_ml/main_screen.dart';
import 'package:image_processing/tesseract.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Extract Text From Image'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Tesseract ORC"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Tesseract())
              ),
            ),
            ElevatedButton(
              child: Text("Google ML Vision"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen())
              ),
            )
          ],
        ),
      ),
    );
  }
}
