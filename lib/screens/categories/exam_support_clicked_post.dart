import 'package:flutter/material.dart';

class ExamSupportPage extends StatefulWidget {
  const ExamSupportPage({super.key});

  @override
  _ExamSupportPageState createState() => _ExamSupportPageState();
}

class _ExamSupportPageState extends State<ExamSupportPage> {
  // Handle button press
  void _handleContactSchool() {
    // Your logic to handle the contact school button
    print("Contact School Pressed");
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
                image:
                    AssetImage('assets/images/backg3.png'), // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Positioned Elements
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A/L Exam',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 180,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School name',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Main Content (Card)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 100), // Space at the top

                    // Card Container
                    Card(
                      elevation: 0, // Removes the shadow/outline
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image inside the card
                            Image.asset(
                              'assets/images/exam_support_1.jpg',
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 20),

                            // Seminar Request Text
                            Text(
                              'Physics - Seminar Request',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 10),

                            // Dummy text (Lorem Ipsum)
                            Text(
                              'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Contact School Button
                            ElevatedButton(
                              onPressed:
                                  _handleContactSchool, // Action on press
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                backgroundColor:
                                    Color(0xFF4E9BF2), // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Contact School',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
    home: ExamSupportPage(),
    debugShowCheckedModeBanner: false,
  ));
}
