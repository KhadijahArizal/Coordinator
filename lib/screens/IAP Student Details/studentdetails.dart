import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final String matric;
  //final String salutation;
  final String name;
  final String major;
  final String ic;
  final String email;
  final String contactno; 
  final String citizenship; 
  final String address; 

  const StudentDetails({
    required this.matric,
    //required this.salutation,
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
        title: Text('Matric No: $matric'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), 
        child: ListView(
          children: [
            _buildListTile('Matric No' , matric),
           //_buildListTile('Salutation' , salutation),
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