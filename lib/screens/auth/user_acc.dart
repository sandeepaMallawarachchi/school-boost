import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data on init
  }

  // Load user data from Firestore
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('user_uid'); // Get UID from local storage

    if (uid != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userData.exists) {
        var data = userData.data() as Map<String, dynamic>;
        _usernameController.text = data['username'] ?? '';
        _emailController.text = data['email'] ?? '';
        _contactController.text = data['contact_number'] ?? '';
        _addressController.text = data['address'] ?? '';
      } else {
        print('User data not found for UID: $uid');
      }
    } else {
      print('No UID found in local storage.');
    }
  }

  // Update user details in Firestore
  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('user_uid'); // Get UID from local storage

    if (uid != null) {
      String username = _usernameController.text.trim();
      String email = _emailController.text.trim();
      String contact = _contactController.text.trim();
      String address = _addressController.text.trim();

      bool result = await updateUserDetails(uid, username, email, contact, address);

      if (result) {
        setState(() {
          _isEditing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile.')),
        );
      }
    } else {
      print('No UID found in local storage.');
    }
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
                image: AssetImage('assets/images/Donor_reg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Profile',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Page Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    // User Icon
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.person_outline,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Username Field
                    _buildTextField(_usernameController, 'Username', Icons.person_outline),
                    SizedBox(height: 20),
                    // Email Field
                    _buildTextField(_emailController, 'Email', Icons.email_outlined),
                    SizedBox(height: 20),
                    // Contact Number Field
                    _buildTextField(_contactController, 'Contact Number', Icons.phone_outlined),
                    SizedBox(height: 20),
                    // Address Field
                    _buildTextField(_addressController, 'Address', Icons.location_on_outlined),
                    SizedBox(height: 50),
                    // Divider Line
                    SizedBox(
                      width: 270,
                      child: Divider(
                        color: const Color.fromARGB(255, 11, 87, 162),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 70),
                    // Save Button (only when editing)
                    if (_isEditing)
                      ElevatedButton(
                        onPressed: _saveProfile,
                        child: Text('Save'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                          backgroundColor: Colors.blue.shade700,
                          textStyle: TextStyle(color: Colors.white, fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
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

  // Build reusable text field
  Widget _buildTextField(TextEditingController controller, String hintText, IconData prefixIcon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        onChanged: (value) {
          setState(() {
            _isEditing = true; // Enable Save button when any field is edited
          });
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}