import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart'; // Import crypto for SHA-256 hashing
import 'dart:convert'; // For utf8.encode
import '../../services/auth.dart'; // Import your auth functions
import '../home.dart'; // Home screen to navigate after successful login
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
        // Login successful, navigate to HomeScreen
        print('Login successful: $email');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Login failed
        _showSnackBar('Login failed. Please check your credentials.');
      }
    } else {
      _showSnackBar('Please fill in both fields.');
    }
  }

  // Show a SnackBar message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                image: AssetImage('assets/images/backg.jpg'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Positioned "Welcome Back, Log In!" at the top-left corner
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back,',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Login!',
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Foreground Elements (TextFields, Buttons, etc.)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 200), // Space from the top

                    // Email TextField
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.email), // Changed icon
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password TextField
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.lock_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot Password?" action
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ),

                    // Divider Line
                    SizedBox(
                      width: 270,
                      child: Divider(
                        color: const Color.fromARGB(255, 11, 87, 162),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 50),

                    // Login Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login, // Disable button while loading
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),

                    SizedBox(height: 15),

                    // Register
                    TextButton(
                      onPressed: () {
                        // Navigate to RegisterScreen when "Register" is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpFormScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.blue[700]),
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
