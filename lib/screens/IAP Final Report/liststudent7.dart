import 'package:coordinator/screens/IAP%20Final%20Report/finalreport.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListStudent7 extends StatefulWidget {
  const ListStudent7({Key? key}) : super(key: key);

  @override
  State<ListStudent7> createState() => _ListStudent7State();
}

class _ListStudent7State extends State<ListStudent7> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _finalreportDetailsRef;
  late List<UserData> _userData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _finalreportDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Final Report');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot finalreportSnapshot =
          await _finalreportDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? finalreportData =
          finalreportSnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && finalreportData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && finalreportData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String title = finalreportData[key]['Report Title'] ?? '';
            String namefile = finalreportData[key]['File Name'] ?? '';
            String file = finalreportData[key]['File'] ?? '';
            String date = finalreportData[key]['Date'] ?? '';
            String status = finalreportData[key]['Status'] ?? '';

            UserData userData = UserData(
              matric: matric,
              name: name,
              title: title,
              namefile: namefile,
              file: file,
              date: date,
              status: status,
            );
            _userData.add(userData);
          }
        });
      }

      setState(() {
        _isLoading = false; // Update loading state once data is fetched
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Report'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
     drawer: NavBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Matric')),
                      DataColumn(label: Text('Student Name')),
                      DataColumn(label: Text('File Name')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: _userData.map((userData) {
                      return DataRow(cells: [
                        DataCell(
                          Text(userData.matric),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalReportDetails(
                                  matric: userData.matric,
                                  title: userData.title,
                                  namefile: userData.namefile,
                                  file: userData.file,
                                  date: userData.date,
                                  status: userData.status,
                                ),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Text(userData.name),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalReportDetails(
                                  matric: userData.matric,
                                  title: userData.title,
                                  namefile: userData.namefile,
                                  file: userData.file,
                                  date: userData.date,
                                  status: userData.status,
                                ),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Text(userData.namefile),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalReportDetails(
                                  matric: userData.matric,
                                  title: userData.title,
                                  namefile: userData.namefile,
                                  file: userData.file,
                                  date: userData.date,
                                  status: userData.status,
                                ),
                              ),
                            );
                          },
                        ),
                        DataCell(
                          Text(userData.status),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FinalReportDetails(
                                  matric: userData.matric,
                                  title: userData.title,
                                  namefile: userData.namefile,
                                  file: userData.file,
                                  date: userData.date,
                                  status: userData.status,
                                ),
                              ),
                            );
                          },
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
    );
  }
}

class UserData {
  final String matric;
  final String name;
  final String title;
  final String namefile;
  final String file;
  final String date;
  final String status;

  UserData({
    required this.matric,
    required this.name,
    required this.title,
    required this.namefile,
    required this.file,
    required this.date,
    required this.status,
  });
}
