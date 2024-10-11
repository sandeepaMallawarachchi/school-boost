// database.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

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
  Future<void> addEquipment(String name, String phone, String address,
      String typeOfEquipment, String conditionOfEquipment) async {
    final prefs = await SharedPreferences.getInstance();
    final String? uid =
        prefs.getString('user_uid'); // Get the user ID from local storage

    if (uid != null) {
      await _firestore.collection('equipments').doc(uid).set({
        // Use the UID as the document ID
        'name': name,
        'phone': phone,
        'address': address,
        'typeOfEquipment': typeOfEquipment,
        'conditionOfEquipment': conditionOfEquipment,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      // Handle the case where UID is null, if necessary
      debugPrint('User ID is null. Cannot add equipment.');
    }
  }

  // Get equipment details based on the current user's UID
  Future<List<Map<String, dynamic>>> getUserDonations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? currentUid =
          prefs.getString('user_uid'); // Get user UID from SharedPreferences

      if (currentUid != null) {
        // Query Firestore for donations matching the user UID
        QuerySnapshot querySnapshot = await _firestore
            .collection('equipments')
            .where('user_uid', isEqualTo: currentUid)
            .get();

        // Map each document to a list of equipment details
        List<Map<String, dynamic>> donationList = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return donationList; // Return the list of equipment details
      } else {
        // Return empty list if there's no UID in local storage
        return [];
      }
    } catch (e) {
      // Log the error message and return an empty list
      print('Error getting user donations: $e');
      return [];
    }
  }
}
