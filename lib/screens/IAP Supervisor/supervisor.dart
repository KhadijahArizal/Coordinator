import 'package:flutter/material.dart';

class SupervisorDetails extends StatelessWidget {
  final String matric;
  final String svname;
  final String email;
  final String contact;
 

  const SupervisorDetails({
    required this.matric,
    required this.svname,
    required this.email,
    required this.contact,
   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Matric No: $matric'),
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // Example padding, adjust as needed
        child: ListView(
          children: [

          _buildListTile('Supervisor Name' ,svname),
          _buildListTile('Email' ,email),
          _buildListTile('Contact No' , contact),
         
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