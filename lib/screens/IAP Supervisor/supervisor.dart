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
        title: Text('Student Matric No: $matric'),
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
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
    ),
    child: ListTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), 
               
              ],
            ),
          ),
          const VerticalDivider( 
            color: Colors.black,
            thickness: 1.0,
            width: 1, 
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}