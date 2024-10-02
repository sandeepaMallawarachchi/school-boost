import 'package:flutter/material.dart';
import 'admin/add_campaigns.dart'; // Adjust the path as necessary

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Manage your Account Here!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCampaignScreen(),
                  ),
                );
              },
              child: Text('Add Campaign Card'),
            ),
          ],
        ),
      ),
    );
  }
}
