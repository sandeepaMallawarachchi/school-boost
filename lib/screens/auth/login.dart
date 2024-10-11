import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // For utf8.encode
import '../../services/auth.dart'; // Import your auth functions
import '../../main.dart'; // Home screen to navigate after successful login
import './registration_form.dart'; // Register screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false; // Manage password visibility

  // Hash the password using SHA256 (same as registration)
  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Perform SHA-256 hash
    return digest.toString(); // Return hashed password as string
  }

  // Login function using Firestore to validate credentials
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true; // Start loading
      });

      // Hash the password before validation
      String hashedPassword = hashPassword(password);

      // Call validateUser from auth.dart to check credentials
      bool isValidUser = await validateUser(email, hashedPassword);

      setState(() {
        _isLoading = false; // Stop loading after checking credentials
      });

      if (isValidUser) {
        // Navigate to HomeScreen and clear all previous routes
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()), // Change HomeScreen to HomePage
          (Route<dynamic> route) => false,
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password!')),
        );
      }
    } else {
      // Show message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents background from resizing when keyboard appears
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
                  'User Login',
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
                    SizedBox(height: 80),
                    // Email Field
                    _buildTextField(_emailController, 'Email', Icons.email_outlined, false),
                    SizedBox(height: 20),
                    // Password Field
                    _buildTextField(_passwordController, 'Password', Icons.lock_outline, true),
                    SizedBox(height: 30),
                    // Login Button
                    if (_isLoading)
                      CircularProgressIndicator() // Show loading spinner
                    else
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                          backgroundColor: Colors.blue.shade700, // Use same background blue shade
                          textStyle: TextStyle(color: Colors.white, fontSize: 18), // Ensure white text
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text('Login', style: TextStyle(color: Colors.white)), // Ensure text remains white
                      ),
                    SizedBox(height: 20),
                    // Register Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpFormScreen()), // Ensure proper import
                        );
                      },
                      child: Text(
                        "Don't have an account? Register here",
                        style: TextStyle(color: Colors.blue[900]), // Keep blue text for registration
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

  // Build reusable text field for email and password
  Widget _buildTextField(TextEditingController controller, String hintText, IconData prefixIcon, bool isPassword) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible, // Toggle password visibility
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
              });
            },
          ) : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
