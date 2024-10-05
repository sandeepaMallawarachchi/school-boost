import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt; // Alias the 'encrypt' package
import '../../services/auth.dart'; // Import your auth file for saveUserDetails function
import 'login.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  @override
  _SignUpFormScreenState createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // AES Encryption setup
  final encrypt.Key key = encrypt.Key.fromUtf8('16characterkey!');
  final encrypt.IV iv = encrypt.IV.fromLength(16); // Use an IV for each encryption

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 50,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 210),
                    _buildTextField(_usernameController, 'User Name', Icons.person_outline),
                    SizedBox(height: 20),
                    _buildTextField(_emailController, 'Email', Icons.email_outlined),
                    SizedBox(height: 20),
                    _buildTextField(_contactNumberController, 'Contact Number', Icons.phone,
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 20),
                    _buildTextField(_passwordController, 'Password', Icons.lock_outline,
                        obscureText: true),
                    SizedBox(height: 20),
                    _buildTextField(_confirmPasswordController, 'Confirm Password', Icons.lock_outline,
                        obscureText: true),
                    SizedBox(height: 30),
                    Divider(
                        color: const Color.fromARGB(255, 11, 87, 162),
                        thickness: 2,
                        indent: 35,
                        endIndent: 35),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
                          // Encrypt the password
                          String encryptedPassword = encryptPassword(_passwordController.text.trim());

                          // Call the saveUserDetails function from auth.dart
                          bool success = await saveUserDetails(
                            _usernameController.text.trim(),
                            _emailController.text.trim(),
                            _contactNumberController.text.trim(),
                            encryptedPassword, // Pass the encrypted password
                          );

                          if (success) {
                            _showSuccessAlert(); // Show success alert
                          } else {
                            _showErrorAlert('Failed to register. Please try again.'); // Show error alert
                          }
                        } else {
                          _showErrorAlert('Passwords do not match.');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Create',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
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

  // Build TextField with reusable widget
  Widget _buildTextField(
      TextEditingController controller, String hintText, IconData prefixIcon,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
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
        obscureText: obscureText,
        keyboardType: keyboardType,
      ),
    );
  }

  // Encrypt the password using AES encryption
  String encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64; // Return encrypted password
  }

  // Show success dialog and navigate to the login screen
  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success!'),
        content: Text('Registration successful!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen())); // Navigate to login screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show error dialog
  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
