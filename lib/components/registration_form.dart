import 'package:flutter/material.dart';

class SignUpFormScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpFormScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController(); // New controller

  void _register() {
    // Handle registration logic
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String contactNumber = _contactNumberController.text.trim(); // Add this line

    if (username.isNotEmpty && email.isNotEmpty && password == confirmPassword && contactNumber.isNotEmpty) {
      // Perform registration
      print('Registering user: $username, Email: $email, Contact: $contactNumber');
    } else {
      print('Please fill in all fields correctly');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Decoration with an image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backg.jpg'), // Set your background image here
                fit: BoxFit.cover, // This will cover the whole screen
              ),
            ),
          ),

          Positioned(
            top: 70,  // Adjust this to move the text down or up
            left: 50,  // Adjust this to align the text more left or right
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 34,
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
                    // Spacing from the top
                    SizedBox(height: 210),

                    // Username Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'User Name',
                          hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
                          prefixIcon: Icon(Icons.person_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

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
                          hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
                          prefixIcon: Icon(Icons.email_outlined),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Contact Number Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _contactNumberController, // This should not show an error
                        decoration: InputDecoration(
                          hintText: 'Contact Number', // Updated hint text
                          hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
                          prefixIcon: Icon(Icons.phone), // Phone icon
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                        keyboardType: TextInputType.phone, // Phone keyboard type
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
                          prefixIcon: Icon(Icons.lock_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Confirm Password Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: Colors.grey), // Set hint text color to gray
                          prefixIcon: Icon(Icons.lock_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Divider Line
                    Container(
                      width: 270, // Set the desired width for the divider
                      child: Divider(
                        color: const Color.fromARGB(255, 11, 87, 162),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 50),

                    // Create Button
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation:
                            5,
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Already have an account? Link
                    GestureDetector(
                      onTap: () {
                        // Handle navigation to login
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Already have an account?',
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
    home: SignUpFormScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
