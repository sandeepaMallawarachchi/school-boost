// add_campaign_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'; // For getting temp directory
import 'package:flutter/services.dart'; // For loading asset as byte data
import '../../services/database.dart'; // Import the DatabaseService

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  @override
  _AddCampaignScreenState createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final DatabaseService _dbService = DatabaseService(); // Initialize the service

  // Default image path (in assets)
  final String defaultImagePath = 'assets/images/default.jpg';

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      setState(() {
        _image = null; // No image selected, use the default one
      });
    }
  }

  // Function to upload an image to Firebase Storage
  Future<String> _uploadImage(File image) async {
    return await _dbService.uploadImage(image); // Use the DatabaseService
  }

  // Function to get the default image as a File
  Future<File> _getDefaultImageFile() async {
    final byteData = await rootBundle.load(defaultImagePath); // Load from assets
    final tempDir = await getTemporaryDirectory(); // Get temp directory
    final file = File('${tempDir.path}/default.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  // Function to add a campaign
  void _addCampaign() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      String imageUrl;

      if (_image != null) {
        // Upload the user-selected image to Firebase Storage
        imageUrl = await _uploadImage(_image!);
      } else {
        // No image selected, upload the default image to Firebase Storage
        File defaultImageFile = await _getDefaultImageFile();
        imageUrl = await _uploadImage(defaultImageFile);
      }

      if (imageUrl.isNotEmpty) {
        // Add the campaign to Firestore with the image URL
        await _dbService.addCampaign(title, description, imageUrl);
        Navigator.pop(context); // Go back after adding the campaign
      } else {
        _showSnackBar('Failed to upload image');
      }
    } else {
      _showSnackBar('Please fill in all fields and pick an image');
    }
  }

  // Function to show a SnackBar with a message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backg.jpg'), // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground Elements
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50), // Added spacing at the top

                    // Campaign Title Input
                    Text(
                      'Add Campaign',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Pick Image Button
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Show either the selected image or the default image
                        Container(
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image != null
                                  ? FileImage(_image!)
                                  : AssetImage(defaultImagePath)
                                      as ImageProvider, // Default image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Camera icon over the image
                        Positioned(
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            onPressed: _pickImage, // Open image picker
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Campaign Title',
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Description Input
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.blue[900]),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),

                    // Add Campaign Button
                    ElevatedButton(
                      onPressed: _addCampaign,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Add Campaign',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
