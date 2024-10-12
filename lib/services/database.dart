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
      rethrow;
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

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  //equipment donation
  Future<void> addEquipment(String name, String phone, String address,
      String typeOfEquipment, String conditionOfEquipment) async {
    final prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('user_uid');

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
      debugPrint('User ID is null. Cannot add equipment.');
    }
  }

  // Get equipment details based on the current user's UID
  Future<List<Map<String, dynamic>>> getUserDonations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? currentUid = prefs.getString('user_uid');

      if (currentUid != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('equipments')
            .doc(currentUid)
            .get();

        if (documentSnapshot.exists) {
          return [documentSnapshot.data() as Map<String, dynamic>];
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting user donations: $e');
      return [];
    }
  }

  // Get payments details based on the current user's UID
  Future<List<Map<String, dynamic>>> getUserPayments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? currentUid = prefs.getString('user_uid');

      if (currentUid != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('payments')
            .where('uid', isEqualTo: currentUid)
            .get();

        return querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting user payments: $e');
      return [];
    }
  }

  // Add a payment to Firestore with the user's UID
  Future<void> addPayment(String title, String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final String? uid = prefs.getString('user_uid');

    if (uid == null) {
      print('Error: User ID not found.');
      return;
    }

    try {
      await _firestore.collection('payments').add({
        'uid': uid,
        'title': title,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Payment added successfully');
    } catch (e) {
      print('Error adding payment: $e');
      rethrow;
    }
  }

  // Upload a payslip to Firebase Storage and return the download URL
  Future<String> uploadPayslip(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('pay_slips/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading payslip: $e');
      return '';
    }
  }

  // Fetch campaign donations from Firestore
  Stream<List<Map<String, dynamic>>> getCampaignDonations() {
    return _firestore.collection('payments').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                'title': doc['title'],
                'imageUrl': doc['imageUrl'],
              })
          .toList();
    });
  }

  // Function to get payment details
  Future<List<Map<String, dynamic>>> getPaymentsData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('payments').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching payments data: $e');
      return [];
    }
  }

  // Function to get equipment donation details
  Future<List<Map<String, dynamic>>> getEquipmentData() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('equipments').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching equipment data: $e');
      return [];
    }
  }

  // Add a event to Firestore
  Future<void> addEvent(
      String title, String description, String imageUrl) async {
    try {
      await _firestore.collection('events').add({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding event: $e');
      rethrow;
    }
  }

  // Fetch campaigns from Firestore
  Stream<List<Map<String, dynamic>>> getEvents() {
    return _firestore.collection('events').snapshots().map((snapshot) {
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
  Future<String> uploadEventImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('Event_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}
