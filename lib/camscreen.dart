import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './picclick.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? ImagePath;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Photo Taken'),
        content: Text('Please press CLICKED PIC for checking the pic'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Add functionality for the "OK" button
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;


      final directory = await getApplicationDocumentsDirectory();
      ImagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
      final imageFile = File(ImagePath!);
      await imageFile.writeAsBytes(await (await _controller!.takePicture()).readAsBytes());

      print('Picture saved to $ImagePath');
    } catch (e) {
      print(e);
    }
    _showAlertDialog(context);
  }

  void _onBottomLeftButtonPressed() {
    // Handle the action for the bottom left button here
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: ImagePath!)),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a Picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller!),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: ElevatedButton(
                    onPressed: _onBottomLeftButtonPressed,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding
                    ),
                    child: const Text(
                      'Clicked Pic',
                      style: TextStyle(
                        fontSize: 16, // Text size
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
