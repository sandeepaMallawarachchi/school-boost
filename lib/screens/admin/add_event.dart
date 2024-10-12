import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import '../../services/database.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final DatabaseService _dbService = DatabaseService();
  bool isLoading = false;
  final String defaultImagePath = 'assets/images/default.jpg';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    return await _dbService.uploadEventImage(image);
  }

  Future<File> _getDefaultImageFile() async {
    final byteData = await rootBundle.load(defaultImagePath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/default.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  void _addEvent() async {
    setState(() {
      isLoading = true;
    });

    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      String imageUrl;

      if (_image != null) {
        imageUrl = await _uploadImage(_image!);
      } else {
        File defaultImageFile = await _getDefaultImageFile();
        imageUrl = await _uploadImage(defaultImageFile);
      }

      if (imageUrl.isNotEmpty) {
        await _dbService.addEvent(title, description, imageUrl);
        Navigator.pop(context);
      } else {
        _showSnackBar('Failed to upload image');
      }
    } else {
      _showSnackBar('Please fill in all fields and pick an image');
    }

    setState(() {
      isLoading = false;
    });
  }

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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Add Event',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image != null
                                  ? FileImage(_image!)
                                  : AssetImage(defaultImagePath)
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.blue[900],
                              size: 30,
                            ),
                            onPressed: _pickImage,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Event Title',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.title, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon:
                            Icon(Icons.description, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: isLoading ? null : _addEvent,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 80, vertical: 18),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        isLoading ? 'Adding Event...' : 'Add Event',
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
