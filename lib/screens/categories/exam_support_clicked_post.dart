import 'package:flutter/material.dart';

class ExamSupportPage extends StatefulWidget {
  const ExamSupportPage({super.key});

  @override
  _ExamSupportPageState createState() => _ExamSupportPageState();
}

class _ExamSupportPageState extends State<ExamSupportPage> {
  // Handle button press
  void _handleContactSchool() {
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
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A/L Exam',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
           Positioned(
            top: 160,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'School Name',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                
              ],
            ),
          ),

          // Main Content (Image, Text, and Button)
   Center(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        Spacer(), // This pushes the content down as much as possible

        // Card with shadow and border around the image
 Center(
  child: Padding(
    padding: const EdgeInsets.only(top: 260.0, left: 16.0, right: 16.0), // Adjust the top padding as needed
    child: Column(
      children: [
        // Card with shadow and border around the image
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35, // 35% of the screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 3,
                blurRadius: 8,
                offset: Offset(0, 4), // Position of the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), // Rounded corners for the image
            child: Image.asset(
              'assets/images/exam_support_1.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),

        SizedBox(height: 40),

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

        // Dummy text
        Text(
          '     Lorem ipsum, or lipsum as it is  to an unknown typesetter in the 15th century who is thought to have scrambled parts of Ciceros De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),

        SizedBox(height: 30),

        // Contact School Button
        ElevatedButton(
          onPressed: _handleContactSchool,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 15,
            ),
            backgroundColor: Color(0xFF4E9BF2),
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

        SizedBox(height: 20),

        // Contact School Button
       
        Spacer(), // This pushes the content up from the bottom as needed
      ],
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
