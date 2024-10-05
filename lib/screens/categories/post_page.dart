import 'package:flutter/material.dart';

class BestPerformersScreen extends StatelessWidget {
  const BestPerformersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backg2.jpg'), // Background image
            fit: BoxFit.cover, // Cover the entire background
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title part
              Text(
                'Support The Best',
                style: TextStyle(
                  fontSize: 32,
                  color: const Color.fromARGB(255, 4, 3, 69),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),

              // Use Expanded to make the performer content fill the remaining screen
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // A/L Best Performers with Horizontal Scroll
                      _buildCategorySection('A/L Exam - Best Performers', [
                        _buildPerformerCard('Nethmi'),
                        _buildPerformerCard('Sanduni'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                      ]),
                      SizedBox(height: 25),

                      // O/L Best Performers with Horizontal Scroll
                      _buildCategorySection('O/L Exam - Best Performers', [
                        _buildPerformerCard('Amali'),
                        _buildPerformerCard('Sachini'),
                        _buildPerformerCard('Nimesha'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                      ]),
                      SizedBox(height: 25),

                      // Grade 5 Best Performers with Horizontal Scroll
                      _buildCategorySection('Grade 5 Exam - Best Performers', [
                        _buildPerformerCard('Kasuni'),
                        _buildPerformerCard('Ridmi'),
                        _buildPerformerCard('Parami'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                        _buildPerformerCard('Tashni'),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create a section for best performers with horizontal scrolling
  Widget _buildCategorySection(String title, List<Widget> performerCards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: Row(
            children: performerCards
                .map((card) => Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0), // Add padding between cards
                      child: card,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  // Helper method to create a performer card with rounded square image
  Widget _buildPerformerCard(String name) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15), // Rounded corners for the card
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15), // Rounded corners for the image
            child: Image.asset(
              'assets/images/category1.jpg', // Use the same image for all cards
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BestPerformersScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
