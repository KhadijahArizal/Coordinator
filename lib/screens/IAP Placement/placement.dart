

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacementDetails extends StatefulWidget {
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
  String status;
  final String studentID;
  final Function(String) onActive;
  final Function(String) onInactive;
  final Function(String) onUpdateStatus;

   PlacementDetails({
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
     required this.status,
    required this.studentID,
    required this.onActive,
    required this.onInactive,
    required this.onUpdateStatus,
   
  });

  

 @override
  _PlacementDetailsState createState() => _PlacementDetailsState();
}

  class _PlacementDetailsState extends State<PlacementDetails> {
  String studentID = '';
  late DatabaseReference _placementForm;
  String status = '';
  late Future<List<PlacementDetails>> _userFinalFuture;

  @override
  void initState() {
    super.initState();
    if (widget.studentID.isNotEmpty) {
      studentID = widget.studentID;
      _placementForm = FirebaseDatabase.instance.ref('Student').child('Company Details').child(widget.studentID);
      _userFinalFuture = _fetchFinalData(widget.studentID);
      //localStatus = widget.status;
      _fetchStatusFromFirebase();
    }
  }

  Future<void> _fetchStatusFromFirebase() async {
    try {
      DataSnapshot snapshot = await _placementForm!.child('Status').once().then((event) => event.snapshot);
      if (snapshot.value != null) {
        setState(() {
          status = snapshot.value.toString();
        });
      }
    } catch (e) {
      print('Error fetching status: $e');
    }
  }


  Future<List<PlacementDetails>> _fetchFinalData(String studentID) async {
    List<PlacementDetails> userDataList = [];
    try {
      DataSnapshot placementFormSnapshot =
          await _placementForm.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? placementFormData =
          placementFormSnapshot.value as Map<dynamic, dynamic>?;

      if (placementFormData != null) {
        placementFormData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            String matric = value['Matric'] ?? '';
            String comname = value['Name'] ?? '';
            String zone = value['Email'] ?? '';
            String postcode = value['Major'] ?? '';
            String address = value['Admission Type'] ?? '';
            String industry = value['Univ Required Course'] ?? '';
            String allowance = value['Department Required Course'] ?? '';
            String duration = value['Kulliyyah Required Course'] ?? '';
            String sector = value['Department Elective Course'] ?? '';
            String start = value['CH Current Sem'] ?? '';
            String end = value['Total CH'] ?? '';
            String offer = value['Semester'] ?? '';
            String status = value['Status'] ?? '';
            String studentID = value[''] ?? '';

            if (key == studentID) {
              PlacementDetails userF = PlacementDetails(
                studentID: studentID,
                matric: matric,
                comname: comname,
                zone: zone,
                postcode: postcode,
                address: address,
                industry: industry,
                allowance: allowance,
                duration: duration,
                sector: sector,
                start: start,
                end: end,
                offer: offer,
                status: status,
                onActive: (String) {},
                onInactive: (String) {},
                onUpdateStatus: (String) {},
              );
              userDataList.add(userF);
            }
          }
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return userDataList;
  }



  void updateStatusInDatabase(String newStatus) async {
    try {
      if (_placementForm != null) {
        await _placementForm.child('Status').set(newStatus);
        setState(() {
          status = newStatus;
        });
      }
    } catch (error) {
      print('Error updating status: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Matric No: ${widget.matric}'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0), // Example padding, adjust as needed
        child: ListView(
          children: [

           _buildDetailStatus('Status:', status),
            _buildStatusDropdown(
              status: status,
              onChanged: (newValue) async {
                setState(() {
                  status = newValue!;
                });
                if (studentID.isNotEmpty) {
                  try {
                    DatabaseReference _placementForm = FirebaseDatabase.instance
                        .ref('Student')
                        .child('Company Details')
                        .child(studentID) // Verify the correctness of this path
                        .child('Status');

                    // Update Firebase database
                    await _placementForm.set(newValue);
                  } catch (error) {
                    print('Error updating status: $error');
                  }
                } else {
                  print('Error: studentID is empty or null');
                }
              },
            ), 

             //_buildListTile('User UID', studentID),
            _buildListTile('Zone' ,widget.zone),
          _buildListTile('Company Name' ,widget.comname),
          _buildListTile('Address' ,widget.address),
          _buildListTile('Postcode' , widget.postcode),
          _buildListTile('Industry', widget.industry),
          _buildListTile('Monthly Allowance' ,widget.allowance),
          _buildListTile('Duration', widget.duration),
          _buildListTile('Sector' ,widget.sector),
          _buildListTile('Start Date' , widget.start),
          _buildListTile('End Date' ,widget.end),
         
          _buildListTileWithGDViewer(
                'Offer Letter', widget.offer),
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
          'Offer Letter',
          style: TextStyle(
            color: Colors.blue, // Make the link text blue
            decoration: TextDecoration.underline, // Underline the link text
          ),
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

 Widget _buildDetailStatus(String label, String value) {
    String status = (value == 'Active' || value == 'Inactive') ? value : 'Inactive';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black54),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              status,
              style: TextStyle(
                  fontSize: 15,
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ],
    );
  }

  Widget _buildStatusDropdown({
    required String status,
    required void Function(String?)? onChanged,
  }) {
    status = (status == 'Active' || status == 'Inactive') ? status : 'Inactive';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: status,
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down_rounded), // Add dropdown icon
          items:
              <String>['Inactive', 'Active'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: _getStatusColor(value),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Active':
        return Colors.green[700]!;
      case 'Inactive':
        return Colors.red[700]!;
      default:
        return Colors.black87; // Default color
    }
  }
}


