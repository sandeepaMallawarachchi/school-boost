import 'package:flutter/material.dart';
// import 'user_onboarding_screen3.dart';

class UserOnboardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Logo and app title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/logo.png', width: 50, height: 50),
                    SizedBox(width: 10),
                    Text(
                      'School Boost',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), 
                // Welcome message
                Text(
                  'Make a Difference Today!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10), 
                // Description
                Text(
                  'Our contribution can transform the lives of students and uplift entire school communities.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30), 
                // Main illustration (add your own image)
                Image.asset('assets/images/userOnboarding3.png', height: 250),
                SizedBox(height: 30), 
                // Get Started button
                ElevatedButton(
                  onPressed: () {
                    // Handle button press, navigate to next screen or home
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue[900],
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Skip button in the bottom-right corner
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserOnboardingScreen3()),
                // );
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
