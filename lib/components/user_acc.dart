import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _editProfile() {
    // Handle Edit Profile logic
    String email = _emailController.text.trim();
    String contact = _contactController.text.trim();
    String age = _ageController.text.trim();
    String address = _addressController.text.trim();

    // Perform some action with this data
    print('Email: $email, Contact: $contact, Age: $age, Address: $address');
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
                image: AssetImage('assets/images/Donor_reg.jpg'), // Set the background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 60,  // Adjust this to move the text down or up
            left: 40,  // Adjust this to align the text more left or right
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Name',
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
                            color: Colors.black.withOpacity(0.3),  // Shadow color with some opacity
                            blurRadius: 5,  // Blur radius for softness
                            spreadRadius: 2,  // Spread of the shadow
                            offset: Offset(0, 3),  // Offset to drop the shadow below the avatar
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

                    // Email Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),  // Set hint text color to gray
                          prefixIcon: Icon(Icons.email_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    // SizedBox(height: 20),

                    // Contact Number Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _contactController,
                        decoration: InputDecoration(
                          hintText: 'Contact Number',
                          hintStyle: TextStyle(color: Colors.grey),  // Set hint text color to gray
                          prefixIcon: Icon(Icons.phone_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Age Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          hintText: 'Birthday',
                          hintStyle: TextStyle(color: Colors.grey),  // Set hint text color to gray
                          prefixIcon: Icon(Icons.cake_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Address Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(color: Colors.grey),  // Set hint text color to gray
                          prefixIcon: Icon(Icons.location_on_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 90),

                    // Edit Profile Button with Shadow
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),  // Shadow color with some opacity
                            blurRadius: 5,  // Blur radius for softness
                            spreadRadius: 2,  // Spread of the shadow
                            offset: Offset(0, 3),  // Offset to drop the shadow below the button
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),  // Same border radius as the button
                      ),
                      child: ElevatedButton(
                        onPressed: _editProfile,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),

                    // Log Out Link
                    GestureDetector(
                      onTap: () {
                        // Handle log out logic
                        print('User logged out');
                      },
                      child: Text(
                        'Log Out?',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.bold,
                        ),
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

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
