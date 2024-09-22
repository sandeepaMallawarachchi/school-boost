import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SchoolBoostApp());
}

class SchoolBoostApp extends StatelessWidget {

  const SchoolBoostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Boost',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Starting with the HomePage that contains the nav bar
    );
  }
}

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Keep track of the currently selected index in the BottomNavigationBar
  int _selectedIndex = 0;

  // List of the screens corresponding to each nav bar item
  final List<Widget> _screens = [
    HomeScreen(), // Correctly reference HomeScreen here
    DonationScreen(),
    UpdatesScreen(),
    AccountScreen(),
  ];

  // Function to handle when a BottomNavigationBar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Keep all icons visible
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Donation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the selected item
        selectedItemColor: Colors.blue[900], // Selected item color
        onTap: _onItemTapped, // Call the function when an item is tapped
      ),
    );
  }
}

// Donation Screen
class DonationScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation'),
      ),
      body: Center(
        child: Text('Make a Donation Here!'),
      ),
    );
  }
}

// Updates Screen
class UpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
      ),
      body: Center(
        child: Text('See the Latest Updates Here!'),
      ),
    );
  }
}

// Account Screen
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Center(
        child: Text('Manage your Account Here!'),
      ),
    );
  }
}