import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Image Viewer'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Image.network(
              imagePath,
              // height: constraints.maxHeight,
              width: constraints.maxWidth, // Set the width to the available width
              fit: BoxFit.contain, // Adjust the image to fit within the width while preserving its aspect ratio
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error); // Display an error icon if image fails to load
              },
            ),
          );
        },
      ),
    );
  }
}
