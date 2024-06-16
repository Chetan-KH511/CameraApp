import 'package:flutter/material.dart';
import './camscreen.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Welcomt to Camera')),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 59, 107, 250),
                  Color.fromARGB(255, 16, 200, 247),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Color.fromARGB(255, 255, 105, 68)
                  .withOpacity(0.5), // Shadow color
              elevation: 10, // Elevation
              padding:
                  EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
            ),
            child: Text(
              'Scan Product',
              style: TextStyle(
                fontSize: 18, // Text size
                fontWeight: FontWeight.bold, // Text weight
              ),
            ),
          ),
        ),
      ),
    );
  }
}
