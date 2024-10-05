import 'package:flutter/material.dart';
import '../../services/database.dart';
import '../../widgets/campaign_card.dart';
import 'admin/add_campaigns.dart';

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
                    actions: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddCampaignScreen(),
                            ),
                          );
                        },
                      ),
                    ],
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
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category2.jpg',
                          label: 'Exam Support',
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category3.jpg',
                          label: 'Events',
                        ),
                        CategoryCard(
                          imagePath: 'assets/images/category4.jpg',
                          label: 'Best Performers',
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final campaigns = snapshot.data!;

                        return ListView.builder(
                          itemCount: campaigns.length,
                          itemBuilder: (context, index) {
                            final campaign = campaigns[index];

                            return CampaignCard(
                              imagePath: campaign['imageUrl'],
                              title: campaign['title'],
                              description: campaign['description'],
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

  const CategoryCard({
    required this.imagePath,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
