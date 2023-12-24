import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final String matric;
  final String salutation;
  final String name;
  final String major;
  final String ic;
  final String email;
  final String contactno; 
  final String citizenship; 
  final String address; 

  const StudentDetails({
    required this.matric,
    required this.salutation,
    required this.name,
    required this.major,
    required this.ic,
    required this.email,
    required this.contactno,
    required this.citizenship,
    required this.address,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details - Matric No: $matric'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), 
        child: ListView(
          children: [
            _buildListTile('Matric No' , matric),
           _buildListTile('Salutation' , salutation),
          _buildListTile('Student Name', name),
          _buildListTile('Major' ,major),
          _buildListTile('IC/Passport' ,ic),
          _buildListTile('Email' ,email),
          _buildListTile('Contact No' ,contactno),
          _buildListTile('Citizenship' ,citizenship),
          _buildListTile('Address' ,address),
         
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