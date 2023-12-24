import 'package:flutter/material.dart';


class IAPForm extends StatelessWidget {
  final String matric;
  final String name;
  final String email;
  final String major;
  final String admission;
  final String univ;
  final String department;
  final String kulliyyah;
  final String elective;
  final String ch;
  final String total;
  final String semester;

  const IAPForm({
    required this.matric,
    required this.name,
    required this.email,
    required this.major,
    required this.admission,
    required this.univ,
    required this.department,
    required this.kulliyyah,
    required this.elective,
    required this.ch,
    required this.total,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student IAP Form - Matric No: $matric'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // Example padding, adjust as needed
        child: ListView(
          children: [
            _buildListTile('Matric No', matric),
            _buildListTile('Student Name', name),
            _buildListTile('Email', email),
            _buildListTile('Major' ,major),
            _buildListTile('Admission Type' ,admission),
            _buildListTile('University Required Course', univ),
            _buildListTile('Department Required Course' , department),
            _buildListTile('Kulliyyah Required Course' , kulliyyah),
            _buildListTile('Department Elective Course' , elective),
            _buildListTile('CH Current Sem' , ch),
            _buildListTile('Total CH' ,total),
            _buildListTile('Semester' , semester),
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

 