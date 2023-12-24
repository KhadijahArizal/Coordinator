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
        title: Text('User Details - $matric'),
        // You can customize the app bar title to display user information
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Matric No: $matric'),
           Text('Salutation: $salutation'),
          Text('Student Name: $name'),
          Text('Major: $major'),
          Text('IC/Passport: $ic'),
          Text('Email: $email'),
          Text('Contact No: $contactno'),
          Text('Citizenship: $citizenship'),
          Text('Address: $address'),
         
        ],
      ),
    );
  }
}
