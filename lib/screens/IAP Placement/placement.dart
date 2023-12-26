import 'package:flutter/material.dart';

class PlacementDetails extends StatelessWidget {
  final String matric;
  final String zone;
  final String comname;
  final String address;
  final String postcode;
  final String industry;
  final String allowance;
  final String duration;
  final String sector;
  final String start;
  final String end;
  final String offer;

  const PlacementDetails({
    required this.matric,
    required this.zone,
    required this.comname,
    required this.address,
    required this.postcode,
    required this.industry,
    required this.allowance,
    required this.duration,
    required this.sector,
    required this.start,
    required this.end,
    required this.offer,
   
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

            _buildListTile('Zone' ,zone),
          _buildListTile('Company Name' ,comname),
          _buildListTile('Address' ,address),
          _buildListTile('Postcode' , postcode),
          _buildListTile('Industry', industry),
          _buildListTile('Monthly Allowance' ,allowance),
          _buildListTile('Duration', duration),
          _buildListTile('Sector' ,sector),
          _buildListTile('Start Date' , start),
          _buildListTile('End Date' ,end),
          _buildListTile('Offer Letter' ,offer),
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