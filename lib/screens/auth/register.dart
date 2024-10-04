import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Navigate to Donor Account SignUp form
  void _handleDonorAccount() {
    // Navigate to the donor registration form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DonorSignUpScreen(),
      ),
    );
  }

  // Navigate to School Account SignUp form
  void _handleSchoolAccount() {
    // Navigate to the school registration form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SchoolSignUpScreen(),
      ),
    );
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

          // Positioned Text "Hello! Sign Up"
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Foreground Elements
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 200), // Adjust space at the top

                    // "Select Your Account Type" Text
                    Text(
                      'Select Your Account Type',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 80),

                    // Donor Account Button
                    ElevatedButton(
                      onPressed: _handleDonorAccount, // Handle donor logic
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Donor Account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Divider Line
                    SizedBox(
                      width: 200,
                      child: Divider(
                        color: const Color.fromARGB(255, 11, 87, 162),
                        thickness: 2,
                      ),
                    ),
                    SizedBox(height: 20),

                    // School Account Button
                    ElevatedButton(
                      onPressed: _handleSchoolAccount, // Handle school logic
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 18,
                        ),
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'School Account',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),

                    SizedBox(height: 20),
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

// Mock Donor SignUp Screen (Replace with actual screen later)
class DonorSignUpScreen extends StatelessWidget {
  const DonorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donor Sign Up')),
      body: Center(child: Text('Donor Sign Up Form')),
    );
  }
}

// Mock School SignUp Screen (Replace with actual screen later)
class SchoolSignUpScreen extends StatelessWidget {
  const SchoolSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('School Sign Up')),
      body: Center(child: Text('School Sign Up Form')),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
