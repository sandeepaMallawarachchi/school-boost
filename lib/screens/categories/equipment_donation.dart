import 'package:flutter/material.dart';
import '../../widgets/equipment_donation_form.dart'; // Import your form

class EquipmentDonationPage extends StatefulWidget {
  @override
  _EquipmentDonationPageState createState() => _EquipmentDonationPageState();
}

class _EquipmentDonationPageState extends State<EquipmentDonationPage> {
  bool _showForm = false; // Controls whether to show the form or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend body behind the app bar to see the background image
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Make the AppBar transparent
        title: Text('Donate Equipment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Donor_reg.jpg'), // Add the background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centering the content vertically
          Center(
            child: _showForm ? EquipmentDonationForm() : _buildInitialContent(),
          ),
        ],
      ),
    );
  }

  // Build Hero Section and Donation Guidelines
  Widget _buildInitialContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center, // Center vertically within the Column
        children: [
          DonationGuidelines(),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showForm = true; // Show the form after clicking next
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                backgroundColor: Colors.blue.shade700,
                textStyle: TextStyle(color: Colors.white), // White text for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text('Next', style: TextStyle(color: Colors.white)), // Ensure text is white
            ),
          ),
        ],
      ),
    );
  }
}

// Donation Guidelines
class DonationGuidelines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.8), // Make the guidelines section semi-transparent
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Donation Guidelines',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '- Ensure the equipment is clean and in usable condition.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            '- For larger items, contact us to schedule a pickup.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            '- Please package the equipment properly to avoid damage during transportation.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}