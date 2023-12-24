import 'package:flutter/material.dart';

class PlacementDetails extends StatelessWidget {
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
        title: Text('User Details - $comname'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Zone: $zone'),
          Text('Company Name: $comname'),
          Text('Address: $address'),
          Text('Postcode: $postcode'),
          Text('Industry: $industry'),
          Text('Monthly Allowance: $allowance'),
          Text('Duration: $duration'),
          Text('Sector: $sector'),
          Text('Start Date: $start'),
          Text('End Date: $end'),
          Text('Offer Letter: $offer'),
        ],
      ),
    );
  }
}
