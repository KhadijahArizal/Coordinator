import 'package:flutter/material.dart';

class StudentSurvey extends StatelessWidget {
  final String matric;
  //final String salutation;
  final String name;
  final String major;
  //final String studID;
  final int rating;
  final String comment; 
  final String learnt; 
  final String offer; 
  final String wish;
  final String best;

  const StudentSurvey({
    required this.matric,
    //required this.salutation,
    required this.name,
    required this.major,
   // required this.studID,
    required this.rating,
    required this.comment,
    required this.learnt,
    required this.offer,
     required this.wish,
      required this.best,

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
          //_buildListTile('Student ID' ,studID),
          _buildListTileRating('Rating' ,rating),
          _buildListTile('Comments and Suggestions for IAP' ,comment),
          _buildListTile('Important thing that you learnt' ,learnt),
          _buildListTile('Offered a job' ,offer),
          _buildListTile('Your wish if you had more time' ,wish),
          _buildListTile('Your best work during IAP' ,best),
         
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


Widget _buildListTileRating(String label, int data) {
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
                  data.toString(),
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