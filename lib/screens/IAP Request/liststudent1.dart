import 'package:coordinator/screens/IAP%20Request/iapform.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserData {
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

  UserData({
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
    required this.onApprove,
    required this.onPending,
    required this.onReject,
    required this.studentID,
  });
}

class ListStudent1 extends StatefulWidget {
  const ListStudent1({Key? key}) : super(key: key);

  @override
  State<ListStudent1> createState() => _ListStudent1State();
}

class _ListStudent1State extends State<ListStudent1> {
  late DatabaseReference _iapForm;
  late Future<List<UserData>> _userFinalFuture;

  @override
  void initState() {
    super.initState();
    _iapForm =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _userFinalFuture = _fetchFinalData();
  }

  Future<List<UserData>> _fetchFinalData() async {
    List<UserData> userDataList = [];
    try {
      DataSnapshot iapFormSnapshot =
          await _iapForm.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapFormData =
          iapFormSnapshot.value as Map<dynamic, dynamic>?;

      if (iapFormData != null) {
        iapFormData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            // Extracting data fields from Firebase and creating UserData objects
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
            String studentID = key as String? ?? '';

            UserData user = UserData(
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
              confirmation: confirmation,
              graduation: graduation,
              partial: partial,
              status: status,
              studentID: studentID,
              onApprove: (String) {},
              onPending: (String) {},
              onReject: (String) {},
            );

            userDataList.add(user);
          }
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    return userDataList;
  }

  Color getStatusColor(String? status) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
        centerTitle: true,
        title: const Text(
          'Industrial Attachment Programme Form',
        ),
      ),
      drawer: NavBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
                'images/iiumlogo.png'), // Add your desired image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
          //border: Border.all(color: Colors.black), // Add a border
          borderRadius: BorderRadius.circular(10.0), // Add border radius
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5), // Add shadow color
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin:
            const EdgeInsets.only(top: 20), // Adjust the top margin as needed
        child: FutureBuilder<List<UserData>>(
          future: _userFinalFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            } else {
              return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('Matric No')),
                      const DataColumn(label: Text('Student Name')),
                      const DataColumn(label: Text('Major')),
                      const DataColumn(label: Text('Status')),
                    ],
                    rows: snapshot.data!.map((user) {
                      return DataRow(cells: [
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IAPForm(
                                    matric: user.matric,
                                    name: user.name,
                                    email: user.email,
                                    major: user.major,
                                    admission: user.admission,
                                    univ: user.univ,
                                    department: user.department,
                                    kulliyyah: user.kulliyyah,
                                    elective: user.elective,
                                    ch: user.ch,
                                    total: user.total,
                                    semester: user.semester,
                                    confirmation: user.confirmation,
                                    graduation: user.graduation,
                                    partial: user.partial,
                                    status: user.status,
                                    studentID: user.studentID,
                                    onApprove: (String) {},
                                    onPending: (String) {},
                                    onReject: (String) {},
                                    onUpdateStatus: (String) {},
                                  ),
                                ),
                              );
                            },
                             child: Text(
                                  user.matric,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(76, 175, 80, 1), // Change underline color if needed
                                  ),
                                ),
                              ),
                            ),
                        DataCell(Text(user.name)),
                        DataCell(Text(user.major)),
                        DataCell(
                          Text(
                            user.status,
                            style: TextStyle(
                              color: getStatusColor(user.status),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
