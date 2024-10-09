// database.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Add a campaign to Firestore
  Future<void> addCampaign(
      String title, String description, String imageUrl) async {
    try {
      await _firestore.collection('campaigns').add({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding campaign: $e');
      rethrow; // Throwing error so that it can be caught in the UI layer
    }
  }

  // Fetch campaigns from Firestore
  Stream<List<Map<String, dynamic>>> getCampaigns() {
    return _firestore.collection('campaigns').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                'title': doc['title'],
                'description': doc['description'],
                'imageUrl': doc['imageUrl'],
              })
          .toList();
    });
  }

  // Upload an image to Firebase Storage and return the download URL
  Future<String> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('campaign_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL for the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return ''; // Return an empty string on error
    }
  }

  //equipment donation
  Future<void> addEquipment(
    String name, String phone, String address, String type, String condition, String pickupLocation) async {
  try {
    await _firestore.collection('equipments').add({
      'name': name,
      'phone': phone,
      'address': address,
      'type': type,
      'condition': condition,
      'pickupLocation': pickupLocation,
      'createdAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    print('Error adding equipment: $e');
    rethrow;
  }
}
}