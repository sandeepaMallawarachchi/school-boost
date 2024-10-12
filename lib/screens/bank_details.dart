import 'package:flutter/material.dart';
import 'package:school_boost/widgets/upload_slip_popup.dart';

void main() => runApp(const BankDetails());

class BankDetails extends StatelessWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BankDetailsPage(campaignTitle: 'Your Campaign Tixxtle Here'),
    );
  }
}

class BankDetailsPage extends StatelessWidget {
  final String campaignTitle;

  const BankDetailsPage({
    required this.campaignTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Bank Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/backg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      campaignTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 20),
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
                      height: 60,
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
                    SizedBox(height: 50),
                    // Upload Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SlipUploadWidget(
                              campaignTitle:
                                  campaignTitle, // Pass the campaign title if needed
                              onUploadPressed: () {
                                print('Upload document pressed!');
                              },
                              onSubmitPressed: () {
                                print('Submit button pressed!');
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: const Color.fromRGBO(25, 118, 210, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Upload Slip',
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 255, 254, 254),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Help link
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Help',
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
      ),
    );
  }
}
