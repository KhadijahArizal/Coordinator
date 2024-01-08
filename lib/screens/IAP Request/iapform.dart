import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class IAPForm extends StatefulWidget {
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
  final String confirmation;
  final String graduation;
  final String partial;
  String status;
  final String studentID;
  final Function(String) onApprove;
  final Function(String) onPending;
  final Function(String) onReject;
  final Function(String) onUpdateStatus;

  IAPForm({
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
    required this.confirmation,
    required this.graduation,
    required this.partial,
    required this.status,
    required this.studentID,
    required this.onApprove,
    required this.onPending,
    required this.onReject,
    required this.onUpdateStatus,
  });

  @override
  _IAPFormState createState() => _IAPFormState();
}

class _IAPFormState extends State<IAPForm> {
  String studentID = '';
  late DatabaseReference _iapForm;
  late Future<List<IAPForm>> _userFinalFuture;

  @override
  void initState() {
    super.initState();
    if (widget.studentID.isNotEmpty) {
      studentID = widget.studentID;
      _iapForm = FirebaseDatabase.instance.ref('Student').child('IAP Form');
      _userFinalFuture = _fetchFinalData(widget.studentID);
      //localStatus = widget.status;
    }
  }

  Future<List<IAPForm>> _fetchFinalData(String studentID) async {
    List<IAPForm> userDataList = [];
    try {
      DataSnapshot iapFormSnapshot =
          await _iapForm.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapFormData =
          iapFormSnapshot.value as Map<dynamic, dynamic>?;

      if (iapFormData != null) {
        iapFormData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String email = value['Email'] ?? '';
            String major = value['Major'] ?? '';
            String admission = value['Admission Type'] ?? '';
            String univ = value['Univ Required Course'] ?? '';
            String department = value['Department Required Course'] ?? '';
            String kulliyyah = value['Kulliyyah Required Course'] ?? '';
            String elective = value['Department Elective Course'] ?? '';
            String ch = value['CH Current Sem'] ?? '';
            String total = value['Total CH'] ?? '';
            String semester = value['Semester'] ?? '';
            String partial = value['Partial Transcript'] ?? '';
            String graduation = value['Graduation Audit'] ?? '';
            String confirmation = value['Confirmation Letter'] ?? '';
            String status = value['Status'] ?? '';
            String studentID = value[''] ?? '';

            if (key == studentID) {
              IAPForm userF = IAPForm(
                studentID: studentID,
                matric: matric,
                name: name,
                email: email,
                major: major,
                admission: admission,
                univ: univ,
                department: department,
                kulliyyah: kulliyyah,
                elective: elective,
                ch: ch,
                total: total,
                semester: semester,
                partial: partial,
                graduation: graduation,
                confirmation: confirmation,
                status: status,
                onApprove: (String) {},
                onPending: (String) {},
                onReject: (String) {},
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

  void updateStatusInDatabase(String newStatus) {
    DatabaseReference _iapForm = FirebaseDatabase.instance
        .ref('Student')
        .child('IAP Form')
        .child(studentID) // Consider verifying the correctness of this path
        .child('Status');

    _iapForm.update({
      'Status': newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matric No: ${widget.matric}'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
         // Set the background color
        image: DecorationImage(
          image: const AssetImage('images/iiumlogo.png'), // Add your desired image
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white30.withOpacity(0.2),
            BlendMode.dstATop,
          ),
        ),
        //border: Border.all(color: Colors.black), // Add a border
        borderRadius: BorderRadius.circular(10.0), // Add border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Add shadow color
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
            _buildDetailStatus('Status:', widget.status),
            _buildStatusDropdown(
              status: widget.status,
              onChanged: (newValue) async {
                setState(() {
                  widget.status = newValue!;
                });
                if (studentID.isNotEmpty) {
                  try {
                    DatabaseReference _iapForm = FirebaseDatabase.instance
                        .ref('Student')
                        .child('IAP Form')
                        .child(studentID) // Verify the correctness of this path
                        .child('Status');

                    // Update Firebase database
                    await _iapForm.set(newValue);
                  } catch (error) {
                    print('Error updating status: $error');
                  }
                } else {
                  print('Error: studentID is empty or null');
                }
              },
            ),

           // _buildListTile('User UID', studentID),
            _buildListTile('Matric No', widget.matric),
            _buildListTile('Student Name', widget.name),
            _buildListTile('Email', widget.email),
            _buildListTile('Major', widget.major),
            _buildListTile('Admission Type', widget.admission),
            _buildListTile('University Required Course', widget.univ),
            _buildListTile('Department Required Course', widget.department),
            _buildListTile('Kulliyyah Required Course', widget.kulliyyah),
            _buildListTile('Department Elective Course', widget.elective),
            _buildListTile('CH Current Sem', widget.ch),
            _buildListTile('Total CH', widget.total),
            _buildListTile('Semester', widget.semester),

            // Confirmation Letter
            _buildListTileWithGDViewer(
                'Confirmation Letter', widget.confirmation),

            // Graduation Audit
            _buildListTileWithGDViewer('Graduation Audit', widget.graduation),

            // Partial Transcript
            _buildListTileWithGDViewer('Partial Transcript', widget.partial),
          ],
        ),
      ),
    );
  }

Widget _buildListTileWithGDViewer(String label, String gdUrl) {
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
        const SizedBox(width: 10), // Add some spacing between label and GD URL
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () async {
              if (await canLaunch(gdUrl)) {
                await launch(gdUrl);
              } else {
                print('Could not launch $gdUrl');
              }
            },
            child: const Text(
              'Google Drive',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
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





  Widget _buildListTileModified(String label, String data) {
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

  Widget _buildDetailStatus(String label, String value) {
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
              value,
              style: TextStyle(
                  fontSize: 15,
                  color: _getStatusColor(widget.status),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: status,
          onChanged: onChanged,
          icon: const Icon(Icons.arrow_drop_down_rounded), // Add dropdown icon
          items:
              <String>['Approved', 'Pending', 'Rejected'].map((String value) {
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
      case 'Pending':
        return Colors.yellow[700]!;
      case 'Approved':
        return Colors.green[700]!;
      case 'Rejected':
        return Colors.red[700]!;
      default:
        return Colors.black87; // Default color
    }
  }
}
