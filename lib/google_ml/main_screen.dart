import 'package:flutter/material.dart';
import 'package:image_processing/google_ml/camera_preview_scanner.dart';

import 'google_ml_kit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Google ML Vision'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("CameraPreview"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraPreviewScanner())
              ),
            ),
            ElevatedButton(
              child: Text("Picture Scanner"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PictureScanner())
              ),
            )
          ],
        ),
      ),
    );
  }
}
