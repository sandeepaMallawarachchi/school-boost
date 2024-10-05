import 'package:flutter/material.dart';

void main() => runApp(StudentFundApp());

class StudentFundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentFundPage(),
    );
  }
}

class StudentFundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
           Positioned(
            top: 50,
            left: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '      Fund',
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title

          
                  SizedBox(height: 150),
                  // BOC Section
                  Image.asset(
                    'assets/images/BoC.png',
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bank Of Ceylon (BOC)',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'xxxxxxxxxxxxxx',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Kollupitiya Branch',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Divider(
                    color: Colors.blueGrey,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(height: 30),
                  // People's Bank Section
                  Image.asset(
                    'assets/images/peoples bank.png',
                    height: 80,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Peoples Bank',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'xxxxxxxxxxxxxxxxxxxx',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Malabe Branch',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 90),
                  // Upload Button
                  ElevatedButton(
                    onPressed: () {
                      // Upload slip action
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), backgroundColor:const Color.fromRGBO(25, 118, 210, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ), // Background color
                    ),
                    child: Text(
                      'Upload Slip',
                      style: TextStyle(fontSize: 18,
                      color: const Color.fromARGB(255, 255, 254, 254),
                ),
                      
                    ),
                  ),
                  SizedBox(height: 10),
                  // Help link
                  TextButton(
                    onPressed: () {
                      // Help action
                    },
                    child: Text(
                      'help',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 35, 128, 204),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
