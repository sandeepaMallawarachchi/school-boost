import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a campaign to Firestore
  Future<void> addCampaign(String title, String description, String imageUrl) async {
    try {
      await _firestore.collection('campaigns').add({
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding campaign: $e');
    }
  }

  // Fetch campaigns from Firestore
  Stream<List<Map<String, dynamic>>> getCampaigns() {
    return _firestore.collection('campaigns').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => {
            'id': doc.id,
            'title': doc['title'],
            'description': doc['description'],
            'imageUrl': doc['imageUrl'],
          }).toList();
    });
  }
}
