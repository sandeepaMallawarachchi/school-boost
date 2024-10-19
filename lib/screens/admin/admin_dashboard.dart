import 'package:flutter/material.dart';
import 'package:school_boost/screens/admin/all_events.dart';
import 'package:school_boost/screens/admin/add_campaigns.dart';
import 'package:school_boost/screens/auth/login.dart';
import 'package:school_boost/services/database.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Donor_reg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Horizontal scrolling menu
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMenuItem(Icons.campaign, 'Campaigns', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCampaignScreen()),
                        );
                      }),
                      _buildMenuItem(Icons.payment, 'Payments', () {
                        // Navigate to payments page
                      }),
                      _buildMenuItem(Icons.event, 'Events', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllEventsScreen()),
                        );
                      }),
                      _buildMenuItem(Icons.contact_mail, 'Contacts', () {
                        // Navigate to contacts page
                      }),
                    ],
                  ),
                ),
              ),
              // Display all campaigns
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: DatabaseService()
                      .getCampaigns(), // Call your function to get campaigns
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No campaigns available.'));
                    }

                    // List of campaigns
                    final campaigns = snapshot.data!;

                    return ListView.builder(
                      itemCount: campaigns.length,
                      itemBuilder: (context, index) {
                        final campaign = campaigns[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: ListTile(
                            leading: Image.network(campaign['imageUrl'],
                                width: 50, fit: BoxFit.cover),
                            title: Text(campaign['title']),
                            subtitle: Text(campaign['description']),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/stats.png',
                      width: 200,
                      height: 250,
                    ),
                    SizedBox(
                        height:
                            20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.blue[900],
            ),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
