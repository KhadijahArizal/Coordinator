import 'package:flutter/material.dart';

class MonthlyReportDetails extends StatelessWidget {
   final String matric;
  final String title;
  final String link;
  final String month;
  final String week;
  final String submission;
  final String feedback;
  final String status;
 

  const MonthlyReportDetails({
    required this.matric,
    required this.title,
    required this.link,
    required this.month,
    required this.week,
    required this.submission,
    required this.feedback,
     required this.status,
   
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

          _buildListTile('Title' ,title),
          _buildListTile('Link' ,link),
          _buildListTile('Month' , month),
          _buildListTile('Week' , week),
          _buildListTile('Submission Date' , submission),
          _buildListTile('Feedback' , feedback),
          _buildListTile('Status' , status),
         
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