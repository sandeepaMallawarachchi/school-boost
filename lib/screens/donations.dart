import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Donations extends StatefulWidget {
  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  late Future<List<Map<String, dynamic>>> _donationsFuture;

  @override
  void initState() {
    super.initState();
    _donationsFuture = DatabaseService().getUserDonations(); // Fetch donations
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'My Donations',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _donationsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'An error occurred. Please try again later.',
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 18),
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No donations yet.',
                          style:
                              TextStyle(color: Colors.blue[900], fontSize: 18),
                        ),
                      );
                    }

                    final donations = snapshot.data!;

                    return ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        var donation = donations[index];
                        var timestamp = donation['timestamp'] as Timestamp;
                        var formattedDate = DateFormat('dd/MM/yyyy hh:mm a')
                            .format(timestamp.toDate());

                        return Card(
                          color: Colors.white.withOpacity(0.85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text(
                              'Donation: ${donation['typeOfEquipment']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Condition: ${donation['conditionOfEquipment']}'),
                                Text('Address: ${donation['address']}'),
                                Text('Date: $formattedDate'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
