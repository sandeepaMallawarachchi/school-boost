import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> saveUserDetails(String username, String email, String contactNumber, String encryptedPassword, String uid, String address) async {
  if (username.isEmpty || email.isEmpty || contactNumber.isEmpty || encryptedPassword.isEmpty || address.isEmpty) {
    print('Missing user details, registration cannot proceed.');
    return false;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('users').doc(uid).set({
      'username': username,
      'email': email,
      'contact_number': contactNumber,
      'password': encryptedPassword,
      'address': address, // Store the address
    });
    print('User details saved to Firestore: $username');
    return true;
  } catch (e) {
    print('Error saving user details: $e');
    return false;
  }
}

// Validate user credentials during login
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

// Retrieve user data from Firestore by UID
Future<Map<String, dynamic>?> getUserData(String uid) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    DocumentSnapshot documentSnapshot = await firestore.collection('users').doc(uid).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>?;
    } else {
      print('User data not found for UID: $uid');
      return null;
    }
  } catch (e) {
    print('Error retrieving user data: $e');
    return null;
  }
}
