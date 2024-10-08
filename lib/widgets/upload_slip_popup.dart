import 'package:flutter/material.dart';

class SlipUploadWidget extends StatelessWidget {
  final VoidCallback onUploadPressed;
  final VoidCallback onSubmitPressed;

  SlipUploadWidget({required this.onUploadPressed, required this.onSubmitPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title
        Text(
          'Upload your slip',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20),
        // Upload document area
        GestureDetector(
          onTap: onUploadPressed,
          child: Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 50,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tap to upload',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        // Submit Button
        ElevatedButton(
          onPressed: onSubmitPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ), // Background color
          ),
          child: Text(
            'Upload',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
