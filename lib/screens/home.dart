import 'package:flutter/material.dart';
import 'package:school_boost/screens/events.dart';
import 'package:school_boost/screens/campaign.dart';
import '../../services/database.dart';
import '../../widgets/campaign_card.dart';
import 'package:school_boost/screens/categories/equipment_donation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseService dbService = DatabaseService();

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 57, 171, 253),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  AppBar(
                    title: Text('Home'),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Browse by Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryCard(
                          imagePath: 'assets/images/category1.jpg',
                          label: 'Equipment',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EquipmentDonationPage(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category2.jpg',
                          label: 'Exam Support',
                          onTap: () {
                            // Navigate to Exam Support page if needed
                          },
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category3.jpg',
                          label: 'Events',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventsScreen(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category4.jpg',
                          label: 'Best Performers',
                          onTap: () {
                            // Navigate to Best Performers page if needed
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Latest Campaigns',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: dbService.getCampaigns(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final campaigns = snapshot.data!;

                        return ListView.builder(
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            final campaign = campaigns[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CampaignDetailPage(
                                      imagePath: campaign['imageUrl'],
                                      title: campaign['title'],
                                      description: campaign['description'],
                                    ),
                                  ),
                                );
                              },
                              child: CampaignCard(
                                imagePath: campaign['imageUrl'],
                                title: campaign['title'],
                                description: campaign['description'],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const CategoryCard({
    required this.imagePath,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                height: 90,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
