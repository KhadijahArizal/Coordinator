import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalReportDetails extends StatelessWidget {
  final String matric;
  final String title;
  final String namefile;
  final String file;
  final String date;
  final String status;
 

  const FinalReportDetails({
    required this.matric,
    required this.title,
    required this.namefile,
    required this.file,
    required this.date,
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

          _buildListTile('Report Title' ,title),
          _buildListTile('File Name' ,namefile),
          _buildListTile('Date' , date),
          _buildListTile('Status' , status),
           _buildListTileWithGDViewer('File', file),
         
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

  Widget _buildListTileWithGDViewer(String label, String gdUrl) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: InkWell(
        onTap: () async {
          // ignore: deprecated_member_use
          if (await canLaunch(gdUrl)) {
            // ignore: deprecated_member_use
            await launch(gdUrl);
          } else {
            print('Could not launch $gdUrl');
          }
        },
        child: const Text(
          'Final Report',
          style: TextStyle(
            color: Colors.blue, // Make the link text blue
            decoration: TextDecoration.underline, // Underline the link text
          ),
        ),
      ),
    );
  }

}