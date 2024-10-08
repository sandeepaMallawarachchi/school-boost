import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Function to update user details
  Future<bool> updateUserDetails(
    String uid, 
    String username, 
    String email, 
    String contactNumber, 
    String address,
    {String? profileImageUrl} // Optional profile image URL
  ) async {
    try {
      // Create a map for user data to update
      Map<String, dynamic> userData = {
        'username': username,
        'email': email,
        'contact_number': contactNumber,
        'address': address,
      };

      // If profileImageUrl is provided, add it to the userData map
      if (profileImageUrl != null) {
        userData['profile_image'] = profileImageUrl;
      }

      // Update Firestore document for the user
      await _firestore.collection('users').doc(uid).update(userData);
      return true;
    } catch (e) {
      print('Error updating user details: $e');
      return false;
    }
  }

  // Function to upload profile image to Firebase Storage and return the download URL
  Future<String> uploadProfileImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('profile_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL for the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return ''; // Return an empty string on error
    }
  }

  // Function to save profile image and update Firestore user document
  Future<bool> saveProfileImage(String uid, File image) async {
    try {
      // Upload image to Firebase Storage
      String imageUrl = await uploadProfileImage(image);

      if (imageUrl.isNotEmpty) {
        // Update the user's profile image URL in Firestore
        await _firestore.collection('users').doc(uid).update({
          'profile_image': imageUrl,
        });
        return true;
      }
      return false;
    } catch (e) {
      print('Error saving profile image: $e');
      return false;
    }
  }
}
