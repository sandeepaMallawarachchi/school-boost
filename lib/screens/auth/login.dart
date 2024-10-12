import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:school_boost/screens/admin/admin_dashboard.dart';
import 'dart:convert'; 
import '../../services/auth.dart';
import '../../main.dart';
import './registration_form.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false; 

  String hashPassword(String password) {
    var bytes = utf8.encode(password); 
    var digest = sha256.convert(bytes); 
    return digest.toString();
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      if (email == "admin" && password == "admin") {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AdminDashboard()),
          (Route<dynamic> route) => false,
        );
        return;
      }

      String hashedPassword = hashPassword(password);

      bool isValidUser = await validateUser(email, hashedPassword);

      setState(() {
        _isLoading = false;
      });

      if (isValidUser) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password!')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                          backgroundColor: Colors.blue.shade700,
                          textStyle: TextStyle(color: Colors.white, fontSize: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text('Login', style: TextStyle(color: Colors.white)),
                      ),
                    SizedBox(height: 20),
                    // Register Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpFormScreen()),
                        );
                      },
                      child: Text(
                        "Don't have an account? Register here",
                        style: TextStyle(color: Colors.blue[900]), 
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
        obscureText: isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
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
