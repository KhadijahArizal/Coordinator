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
        title: Text('User Details - $matric'),
        // You can customize the app bar title to display user information
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Matric No: $matric'),
          Text('Student Name: $name'),
          Text('Email: $email'),
          Text('Major: $major'),
          Text('Admission Type: $admission'),
          Text('University Required Course: $univ'),
          Text('Department Required Course: $department'),
          Text('Kulliyyah Required Course: $kulliyyah'),
          Text('Department Elective Course: $elective'),
          Text('CH Current Sem: $ch'),
          Text('Total CH: $total'),
          Text('Semester: $semester'),
        ],
      ),
    );
  }
}
