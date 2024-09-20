import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          
          // Horizontal scrollable categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CategoryCard(
                  imagePath: 'assets/images/category1.jpg', // Equipment image
                  label: 'Equipment',
                ),
                CategoryCard(
                  imagePath: 'assets/images/category2.jpg', // Exam Support image
                  label: 'Exam Support',
                ),
                CategoryCard(
                  imagePath: 'assets/images/category3.jpg', // Events image
                  label: 'Events',
                ),
                CategoryCard(
                  imagePath: 'assets/images/category4.jpg', // Best Performers image
                  label: 'Best Performers',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imagePath;
  final String label;

  CategoryCard({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Width of each category card
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // Category Image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            child: Image.asset(
              imagePath,
              width: 150, // Set uniform width for all images
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          // Category Label
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
