import 'package:flutter/material.dart';
import '../../services/database.dart'; // Adjust the import based on your project structure
import '../../services/auth.dart'; // Import the file where getUserData is defined

class EquipmentDonationForm extends StatefulWidget {
  @override
  _EquipmentDonationFormState createState() => _EquipmentDonationFormState();
}

class _EquipmentDonationFormState extends State<EquipmentDonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _typeOfEquipment = '';
  String _conditionOfEquipment = '';
  String _pickupLocation = '';
  String _name = ''; // User's name
  String _phone = ''; // Allow changing
  String _address = ''; // Allow changing

  // Replace 'your-uid' with the actual UID of the logged-in user
  final String uid = '1728153802305'; 

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the widget is initialized
  }

  Future<void> _loadUserData() async {
    Map<String, dynamic>? userData = await getUserData(uid);

    if (userData != null) {
      setState(() {
        _name = userData['username'] ?? 'N/A'; // Get username
        _phone = userData['contact_number'] ?? ''; // Get contact number
        _address = userData['address'] ?? ''; // Get address
      });
    } else {
      print('No user data found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Donor_reg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 210),
                      // Non-editable name field
                      _buildTextField('Name', Icons.person_outline, initialValue: _name, readOnly: true),
                      SizedBox(height: 20),
                      _buildTextField('Phone', Icons.phone_outlined, initialValue: _phone, onChanged: (value) {
                        _phone = value;
                      }, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      }),
                      SizedBox(height: 20),
                      _buildTextField('Address', Icons.location_on_outlined, initialValue: _address, onChanged: (value) {
                        _address = value;
                      }, validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      }),
                      SizedBox(height: 20),
                      _buildDropdown('Type of Equipment', ['Type 1', 'Type 2', 'Type 3']),
                      SizedBox(height: 20),
                      _buildDropdown('Condition of Equipment', ['New', 'Used', 'Damaged']),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Submit the form
                            await DatabaseService().addEquipment(
                              _name,
                              _phone,
                              _address,
                              _typeOfEquipment,
                              _conditionOfEquipment,
                              _pickupLocation,
                            );
                            // Show success message or navigate to another page
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      FAQs(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build reusable text field
  Widget _buildTextField(String hintText, IconData prefixIcon, {String? initialValue, bool readOnly = false, Function(String)? onChanged, String? Function(String?)? validator}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(prefixIcon),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  // Build reusable dropdown
  Widget _buildDropdown(String label, List<String> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (label == 'Type of Equipment') {
              _typeOfEquipment = value.toString();
            } else if (label == 'Condition of Equipment') {
              _conditionOfEquipment = value.toString();
            }
          });
        },
      ),
    );
  }
}

class FAQs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Frequently Asked Questions:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ExpansionTile(
          title: Text('What items can I donate?'),
          children: [Text('You can donate sports equipment, books, etc.')],
        ),
        ExpansionTile(
          title: Text('How do I schedule a pickup?'),
          children: [Text('Contact us to arrange a pickup time.')],
        ),
      ],
    );
  }
}