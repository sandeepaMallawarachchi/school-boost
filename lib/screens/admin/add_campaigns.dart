import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/database.dart';

class AddCampaignScreen extends StatefulWidget {
  const AddCampaignScreen({super.key});

  @override
  _AddCampaignScreenState createState() => _AddCampaignScreenState();
}

class _AddCampaignScreenState extends State<AddCampaignScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final DatabaseService _dbService = DatabaseService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addCampaign() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty && _image != null) {
      String imageUrl = await _dbService.uploadImage(_image!);
      if (imageUrl.isNotEmpty) {
        await _dbService.addCampaign(title, description, imageUrl);
        Navigator.pop(context);
      } else {
        print('Failed to upload image');
      }
    } else {
      print('Please fill in all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Campaign')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Campaign Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            if (_image != null) ...[
              SizedBox(height: 20),
              Image.file(
                _image!,
                height: 150,
                fit: BoxFit.cover,
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCampaign,
              child: Text('Add Campaign'),
            ),
          ],
        ),
      ),
    );
  }
}