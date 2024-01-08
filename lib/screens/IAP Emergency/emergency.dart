import 'package:flutter/material.dart';

class EmergencyDetails extends StatelessWidget {
  final String matric;
  final String emergname;
  final String contact;
  final String relay;
  final String homeadd;
 

  const EmergencyDetails({
    required this.matric,
    required this.emergname,
    required this.contact,
    required this.relay,
    required this.homeadd,
   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Matric No: $matric'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // Example padding, adjust as needed
        child: ListView(
          children: [

          _buildListTile('Name' ,emergname),
          _buildListTile('Emergency Contact Person' ,contact),
          _buildListTile('Relationship' , relay),
          _buildListTile('Home Address' , homeadd),
         
         ],
        ),
      ),
    );
  }

Widget _buildListTile(String label, String data) {
  return ListTile(
    title: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10), // Add some spacing between label and data
        Expanded(
          flex: 3,
          child: Text(
            data,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    ),
  );
}
}