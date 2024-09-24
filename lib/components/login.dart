import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Mock login function
  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      // Replace this with your actual login logic (e.g., API call)
      bool isAuthenticated = await _authenticateUser(email, password);

      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError('Invalid email or password');
      }
    } else {
      _showError('Please fill in both fields');
    }
  }

  // Mock authentication function
  Future<bool> _authenticateUser(String email, String password) async {
    // Simulate a real authentication request
    await Future.delayed(Duration(seconds: 2));
    // Replace this with actual authentication logic
    return email == 'user@example.com' && password == 'password123';
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Make the background image fill the entire screen
        children: [
          // Background image
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
          // Login form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.white.withOpacity(0.8), // Add transparency to background color
                    filled: true, // Make background of text field white
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.white.withOpacity(0.8),
                    filled: true,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Handle "Forgot Password" here
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
