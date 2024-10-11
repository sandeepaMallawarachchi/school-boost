import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    if (querySnapshot.docs.isNotEmpty) {
      // User exists, save UID to local storage
      String uid = querySnapshot.docs.first.id; // Get the UID from the first document
      await _saveUidToLocalStorage(uid); // Save UID to local storage
      return true;
    }
    
    return false;
  } catch (e) {
    print('Error validating user: $e');
    return false;
  }
}

// Function to save UID to local storage
Future<void> _saveUidToLocalStorage(String uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_uid', uid);
  print('UID saved to local storage: $uid');
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

//update user data
Future<bool> updateUserDetails(String uid, String username, String email, String contactNumber, String address) async {
  if (username.isEmpty || email.isEmpty || contactNumber.isEmpty || address.isEmpty) {
    print('Missing user details, update cannot proceed.');
    return false;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    await firestore.collection('users').doc(uid).update({
      'username': username,
      'email': email,
      'contact_number': contactNumber,
      'address': address,
    });
    print('User details updated in Firestore: $username');
    return true;
  } catch (e) {
    print('Error updating user details: $e');
    return false;
  }
}
