// auth.dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> saveUserDetails(String username, String email, String contactNumber, String encryptedPassword) async {
  if (username.isEmpty || email.isEmpty || contactNumber.isEmpty || encryptedPassword.isEmpty) {
    print('Missing user details, registration cannot proceed.');
    return false;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('users').add({
      'username': username,
      'email': email,
      'contact_number': contactNumber,
      'password': encryptedPassword,
    });
    print('User details saved to Firestore: $username');
    return true;
  } catch (e) {
    print('Error saving user details: $e');
    return false;
  }
}

Future<bool> validateUser(String email, String password) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error validating user: $e');
    return false;
  }
}