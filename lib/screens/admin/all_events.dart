import 'package:flutter/material.dart';
import '../../services/database.dart';
import 'add_event.dart';

class AllEventsScreen extends StatelessWidget {
  final DatabaseService _dbService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Events'),
        backgroundColor: Colors.blue.shade700,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Event List
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: _dbService.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No events available'));
              }

              final events = snapshot.data!;

              return ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: Image.network(
                        event['imageUrl'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        event['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        event['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue.shade700,
      ),
    );
  }
}
