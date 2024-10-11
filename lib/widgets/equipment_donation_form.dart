import 'package:flutter/material.dart';
import '../../services/database.dart';

class EquipmentDonationForm extends StatefulWidget {
  const EquipmentDonationForm({super.key});

  @override
  _EquipmentDonationFormState createState() => _EquipmentDonationFormState();
}

class _EquipmentDonationFormState extends State<EquipmentDonationForm> {
  final _formKey = GlobalKey<FormState>();
  String _typeOfEquipment = '';
  String _conditionOfEquipment = '';
  String _name = '';
  String _phone = ''; 
  String _address = ''; // User will input this manually

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents background from resizing
      body: Container(
        color: Colors.blue[900],
        child: SafeArea(
          child: Stack(
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
                          SizedBox(height: 150),
                          _buildTextField('Name', Icons.person_outline, onChanged: (value) {
                            _name = value;
                          }, validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          }),
                          SizedBox(height: 20),
                          _buildTextField('Phone', Icons.phone_outlined, onChanged: (value) {
                            _phone = value;
                          }, validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          }),
                          SizedBox(height: 20),
                          // Manually inputted address field
                          _buildTextField('Address', Icons.location_on_outlined, onChanged: (value) {
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
                                  _address, // Address entered by user
                                  _typeOfEquipment,
                                  _conditionOfEquipment
                                  // Removed pickupLocation
                                );
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
        ),
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