import 'package:coordinator/screens/IAP%20Supervisor/supervisor.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListStudent4 extends StatefulWidget {
  const ListStudent4({Key? key}) : super(key: key);

  @override
  State<ListStudent4> createState() => _ListStudent4State();
}

class _ListStudent4State extends State<ListStudent4> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _supervisorDetailsRef;
  late List<UserData> _userData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _iapFormRef = FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _supervisorDetailsRef = FirebaseDatabase.instance.ref().child('Student').child('Supervisor Details');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot = await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot supervisorSnapshot = await _supervisorDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData = iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? supervisorData = supervisorSnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && supervisorData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && supervisorData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String svname = supervisorData[key]['Supervisor Name'] ?? '';
            String email = supervisorData[key]['Email'] ?? '';
            String contact = supervisorData[key]['Contact No'] ?? '';

            UserData userData = UserData(
              matric: matric,
              name: name,
              svname: svname,
              email: email,
              contact: contact,
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
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
        centerTitle: true,
        title: const Text('Supervisor'),
      ),
      drawer: NavBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/iiumlogo.png'), // Replace with your image path
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator()
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Center(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Matric')),
                            DataColumn(label: Text('Student Name')),
                            DataColumn(label: Text('Supervisor Name')),
                            DataColumn(label: Text('Email')),
                            DataColumn(label: Text('Contact')),
                          ],
                          rows: _userData.map((userData) {
                            return DataRow(cells: [
                              DataCell(Text(userData.matric)),
                              DataCell(Text(userData.name)),
                              DataCell(Text(userData.svname)),
                              DataCell(Text(userData.email)),
                              DataCell(Text(userData.contact)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}


class UserData {
  final String matric;
  final String name;
  final String svname;
  final String email;
  final String contact;

  UserData({
    required this.matric,
    required this.name,
    required this.svname,
    required this.email,
    required this.contact,
  });
}
