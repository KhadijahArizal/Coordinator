// ignore_for_file: camel_case_types

import 'package:coordinator/screens/IAP%20Monthly%20Report/details.dart';
import 'package:coordinator/screens/IAP%20Monthly%20Report/model.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListStudent9 extends StatefulWidget {
  const ListStudent9({Key? key}) : super(key: key);

  @override
  State<ListStudent9> createState() => _ListStudent9State();
}

class _ListStudent9State extends State<ListStudent9> {
  User? user = FirebaseAuth.instance.currentUser;
  String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  late DatabaseReference _iapFormRef;
  late DatabaseReference _monthlyReport;
  late List<UserDataC> userData = [];
  List<MonthlyReportC> monthlyReports = [];
  List<UserDataC> originalUserData = [];

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _monthlyReport = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Monthly Report');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot monthlyReportSnapshot =
          await _monthlyReport.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? monthlyReportData =
          monthlyReportSnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && monthlyReportData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> &&
              monthlyReportData.containsKey(key) &&
              iapData.containsKey(key)) {
            String matric = iapData[key]['Matric'] ?? '';
            String name = iapData[key]['Name'] ?? '';
            String studentID = iapData[key]['Student ID'] ?? '';
            String major = iapData[key]['Major'] ?? '';

            List<MonthlyReportC> monthlyReports = [];
            if (monthlyReportData[key]['Reports'] is Map) {
              monthlyReportData[key]['Reports']
                  .forEach((reportKey, reportValue) {
                MonthlyReportC monthlyReport = MonthlyReportC(
                  month: reportValue['Month'] ?? '',
                  monthlyRname: reportValue['Name'] ?? '',
                  status: reportValue['Status'] ?? '',
                  date: reportValue['Submission Date'] ?? '',
                  monthlyFile: reportValue['File'] ?? '',
                );
                monthlyReports.add(monthlyReport);
              });
            }
            if (studentID == studentID) {
              UserDataC user = UserDataC(
                studentID: studentID,
                matric: matric,
                name: name,
                major: major,
                monthlyReports: monthlyReports,
                finalReport: FinalReportC(
                    date: '',
                    file: '',
                    fileName: '',
                    title: '',
                    status: '',
                    statusSV: ''),
              );

              userData.add(user);
              originalUserData.add(user);
            }

            print('userData: $userData');
          }
        });
      }

      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  List<UserDataC> _filterUserData(String searchValue) {
    return userData
        .where((user) =>
            user.matric.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
  }

  Widget _name({required String name}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontFamily: 'Futura',
            ),
          )
        ],
      );


      Widget _major({required String major}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            major,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontFamily: 'Futura',
            ),
          )
        ],
      );

  Widget _matricNo({required String matricNo}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            matricNo,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'Futura',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Report'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      drawer: NavBar(),
      body: SafeArea(
        child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: const AssetImage('assets/images/iiumlogo.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white30.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          if (value.isEmpty) {
                            // If the search value is empty, reset to the original data
                            userData = originalUserData;
                          } else {
                            // Otherwise, filter the data based on the search value
                            userData = _filterUserData(value);

                            // Check if there are no students matching the search
                            if (userData.isEmpty) {
                              userData.add(UserDataC(
                                // You can customize this message or leave fields empty as needed
                                name: 'No student found',
                                matric: '',
                                studentID: '',
                                major: '',
                                //svemail: '',
                                monthlyReports: [],
                                finalReport: FinalReportC(
                                  date: '',
                                  file: '',
                                  fileName: '',
                                  title: '',
                                  status: '',
                                  statusSV: '',
                                ),
                              ));
                            }
                          }
                        });
                      },
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search student Matric No",
                        prefixIcon: const Icon(Icons.search_rounded),
                        prefixIconColor: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: userData.map((user) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => S_Details(
                                    name: user.name,
                                    matric: user.matric,
                                    studentID: user.studentID,
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Matric No:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Futura',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              _matricNo(matricNo: user.matric),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Name:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Futura',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              _name(name: user.name),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Major:',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontFamily: 'Futura',
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              _major(major: user.major),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ))),
      ),
    );
  }
}
