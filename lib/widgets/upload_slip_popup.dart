import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlipUploadWidget extends StatefulWidget {
  final String campaignTitle;
  final VoidCallback onUploadPressed;
  final VoidCallback onSubmitPressed;

  SlipUploadWidget({
    required this.campaignTitle,
    required this.onUploadPressed,
    required this.onSubmitPressed,
  });

  @override
  _SlipUploadWidgetState createState() => _SlipUploadWidgetState();
}

class _SlipUploadWidgetState extends State<SlipUploadWidget> {
  File? _selectedImage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadPayslip(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('pay_slips/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      return '';
    }
  }

  Future<void> addPayment(String title, String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('user_uid');
    if (uid == null) return;
    try {
      await _firestore.collection('payments').add({
        'uid': uid,
        'title': title,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  void _onUploadPressed() async {
    if (_selectedImage == null) return;
    String imageUrl = await uploadPayslip(_selectedImage!);
    if (imageUrl.isNotEmpty) {
      await addPayment(widget.campaignTitle, imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Slip uploaded and details saved successfully')),
      );

      Navigator.pop(
          context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload slip.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Upload your slip',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: _selectedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          size: 50,
                          color: Colors.blue[600],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tap to upload',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )
                  : Image.file(_selectedImage!, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _onUploadPressed,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            backgroundColor: Colors.blue[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Upload',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
