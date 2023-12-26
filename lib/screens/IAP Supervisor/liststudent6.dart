import 'package:coordinator/screens/IAP%20Supervisor/supervisor.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListStudent6 extends StatefulWidget {
  const ListStudent6({Key? key}) : super(key: key);

  @override
  State<ListStudent6> createState() => _ListStudent6State();
}

class _ListStudent6State extends State<ListStudent6> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _supervisorDetailsRef;
  late List<UserData> _userData = [];

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _supervisorDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Supervisor Details');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot supervisorSnapshot =
          await _supervisorDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? supervisorData =
          supervisorSnapshot.value as Map<dynamic, dynamic>?;

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

      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Students (Supervisor Details)'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),

      ),
      drawer: NavBar(),
      body: _userData.isNotEmpty
          ? ListView.builder(
              itemCount: _userData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_userData[index].name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Matric: ${_userData[index].matric}'),
                      Text('Supervisor Name: ${_userData[index].svname}'),
                      Text('Email: ${_userData[index].email}'),
                      Text('Contact No: ${_userData[index].contact}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupervisorDetails(
                          matric: _userData[index].matric,
                          svname: _userData[index].svname,
                          email: _userData[index].email,
                          contact: _userData[index].contact,
                          
                         
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
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
