import 'dart:async';

import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData {
  final String matric;
  final String name;
  final String major;
  final String zone;
  final String studentID;

  UserData({
    required this.matric,
    required this.name,
    required this.major,
    required this.zone,
    required this.studentID,
  });
}

class examinerDetailsData {
  final String key;
  final String examinerName;
  final String examinerEmail;

  examinerDetailsData({
    required this.key,
    required this.examinerName,
    required this.examinerEmail,
  });
}

class AssignExaminer extends StatefulWidget {
  const AssignExaminer({Key? key}) : super(key: key);

  @override
  State<AssignExaminer> createState() => _AssignExaminerState();
}

class _AssignExaminerState extends State<AssignExaminer> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _companyDetailsRef;
  late DatabaseReference _examinerDetails;
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  late Future<List<UserData>> _userdataFuture;
  late List<examinerDetailsData> _examinerDetailsList = [];
  late List<String> _examinerOptions = [];
  Map<String, UniqueKey> dropdownKeys = {};
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _companyDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Company Details');
    _examinerDetails = FirebaseDatabase.instance.ref().child('Examiners');
    _userdataFuture = _fetchUserData();
    _fetchExaminerDetails();
    _fetchExaminerOptions();
  }

  Future<void> _fetchExaminerDetails() async {
    try {
      DataSnapshot examinerDetailsSnapshot =
          await _examinerDetails.once().then((event) => event.snapshot);

      print('Examiner Snapshot: ${examinerDetailsSnapshot.value}');

      if (examinerDetailsSnapshot.value != null) {
        Map<dynamic, dynamic> examinerData =
            examinerDetailsSnapshot.value as Map<dynamic, dynamic>;

        examinerData.forEach((key, value) {
          String examinerKey = key.toString();
          String examinerName = value['examinerName'] ?? '';
          String examinerEmail = value['examinerEmail'] ?? '';

          examinerDetailsData examiner = examinerDetailsData(
            key: examinerKey,
            examinerName: examinerName,
            examinerEmail: examinerEmail,
          );
          _examinerDetailsList.add(examiner);
        });

        setState(() {}); // Trigger a rebuild to update the DropdownButton
      }
    } catch (e) {
      print('Error fetching examiner details: $e');
    }
  }

  Future<List<UserData>> _fetchUserData() async {
    List<UserData> userDataList = [];
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot companySnapshot =
          await _companyDetailsRef.once().then((event) => event.snapshot);
      DataSnapshot examinerDetailsSnapshot =
          await _examinerDetails.once().then((event) => event.snapshot);

      print('IAP Snapshot: ${iapSnapshot.value}');
      print('Company Snapshot: ${companySnapshot.value}');

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? companyData =
          companySnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? examinerDetailsData =
          examinerDetailsSnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && companyData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && companyData.containsKey(key)) {
            String studentID = value['Student ID'] ?? '';
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String major = value['Major'] ?? '';
            String zone = companyData[key]['Zone'] ?? '';

            UserData user = UserData(
              matric: matric,
              name: name,
              major: major,
              zone: zone,
              studentID: studentID,
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

  Future<void> _fetchExaminerOptions() async {
    try {
      DataSnapshot examinerSnapshot =
          await _examinerDetails.once().then((event) => event.snapshot);

      // Fetch examiner options from the database and store them in _examinerOptions list
      Map<dynamic, dynamic>? examinerData =
          examinerSnapshot.value as Map<dynamic, dynamic>?;

      if (examinerData != null) {
        // Fetch examiner options from 'BIT Examiners' and 'BCS Examiners' nodes
        List<String> bitExaminers = [];
        List<String> bcsExaminers = [];

        if (examinerData.containsKey('BIT Examiners')) {
          Map<dynamic, dynamic>? bitData =
              examinerData['BIT Examiners'] as Map<dynamic, dynamic>?;

          if (bitData != null) {
            bitData.forEach((key, value) {
              bitExaminers.add(value['selectedOption'] ?? '');
            });
          }
        }

        if (examinerData.containsKey('BCS Examiners')) {
          Map<dynamic, dynamic>? bcsData =
              examinerData['BCS Examiners'] as Map<dynamic, dynamic>?;

          if (bcsData != null) {
            bcsData.forEach((key, value) {
              bcsExaminers.add(value['selectedOption'] ?? '');
            });
          }
        }

        _examinerOptions = [...bitExaminers, ...bcsExaminers];
      }
    } catch (e) {
      print('Error fetching examiner options: $e');
    }
  }

  Future<String> _getEmailFromDatabase(String studentID) async {
    try {
      DataSnapshot snapshot = await _databaseReference
          .child('Student/Assign Examiner/$studentID/ExaminerEmail')
          .once()
          .then((event) => event.snapshot);

      if (snapshot.value != null) {
        return snapshot.value.toString();
      } else {
        // Handle cases where data does not exist
        print('No data available for $studentID');
        return ''; // Return an empty string or handle as needed
      }
    } catch (error) {
      // Handle errors while fetching data
      print('Error fetching email for $studentID: $error');
      return ''; // Return an empty string or handle as needed
    }
  }

  void _updateEmailInDatabase(String studentID, String newValue) {
    // Function to update email data in Firebase Realtime Database
    _databaseReference
        .child('Student/Assign Examiner/$studentID/ExaminerEmail')
        .set(newValue)
        .then((_) {
      // Handle successful update
      print('Email updated successfully for $studentID');
    }).catchError((error) {
      // Handle error during update
      print('Error updating email for $studentID: $error');
    });
  }

// Inside your DataTable rows mapping

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
        title: const Text('Assign Examiner'),
        centerTitle: true,
      ),
      drawer: NavBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
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
          ),
          FutureBuilder<List<UserData>>(
              future: _userdataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No data available.'),
                  );
                } else {
                  List<UserData> userData = snapshot.data!;
                  Map<String, String?> _selectedExaminersMap = {};

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Matric No')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Major')),
                            DataColumn(label: Text('Zone')),
                            DataColumn(label: Text('Examiner')),
                            DataColumn(label: Text('Examiner Valid Email')),
                            // Add more DataColumn as needed
                          ],
                          rows: userData.map<DataRow>((user) {
                            return DataRow(cells: [
                              DataCell(Text(user.matric)),
                              DataCell(Text(user.name)),
                              DataCell(Text(user.major)),
                              DataCell(Text(user.zone)),
                              DataCell(
                                FutureBuilder<DataSnapshot>(
                                  future: _databaseReference
                                      .child(
                                          'Student/Assign Examiner/${user.studentID}/ExaminerName')
                                      .once()
                                      .then((event) => event.snapshot),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DataSnapshot> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final selectedExaminer =
                                          snapshot.data!.value as String?;
                                      _selectedExaminersMap[user.matric] =
                                          selectedExaminer ?? 'Select Examiner';
                                      return DropdownButton<String>(
                                        value:
                                            _selectedExaminersMap[user.matric],
                                        items: [
                                          const DropdownMenuItem<String>(
                                            value: 'Select Examiner',
                                            child: Text(
                                              'Select Examiner',
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          ..._examinerOptions.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value ?? 'Select Examiner',
                                              child: Text(
                                                  value ?? 'Select Examiner'),
                                            );
                                          }).toList(),
                                        ],
                                        onChanged: (String? newValue) async {
                                          setState(() {
                                            _selectedExaminersMap[user.matric] =
                                                newValue ?? '';
                                            _databaseReference
                                                .child(
                                                    'Student/Assign Examiner/${user.studentID}/ExaminerName')
                                                .set(newValue ?? '')
                                                .then((_) {
                                              print(
                                                  "_selectedExaminersMap updated: ${_selectedExaminersMap[user.studentID]}");
                                            }).catchError((error) {
                                              print(
                                                  "Error updating database: $error");
                                            });
                                          });
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                              DataCell(
                                FutureBuilder<String>(
                                  future: _getEmailFromDatabase(user.studentID),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        !snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return TextField(
                                        onChanged: (String newValue) {
                                          _updateEmailInDatabase(
                                              user.studentID, newValue);
                                        },
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Enter valid examiner email',
                                          hintStyle: TextStyle(
                                            color: Colors.blueAccent, // Change the color as per your requirement
                                          ),
                                        ),
                                      );
                                    } else {
                                      String email = snapshot.data ?? '';
                                      return TextField(
                                        controller:
                                            TextEditingController(text: email),
                                        onChanged: (String newValue) {
                                          _updateEmailInDatabase(
                                              user.studentID, newValue);
                                        },
                                        decoration: const InputDecoration(
                                          hintText:
                                              'Enter valid examiner email',
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
