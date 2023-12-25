import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListStudent3 extends StatefulWidget {
  const ListStudent3({Key? key}) : super(key: key);

  @override
  State<ListStudent3> createState() => _ListStudent3State();
}

class _ListStudent3State extends State<ListStudent3> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _companyDetailsRef;
  late List<UserData> _userData = [];

  @override
  void initState() {
    super.initState();
    _iapFormRef = FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _companyDetailsRef = FirebaseDatabase.instance.ref().child('Student').child('Company Details');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot = await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot companySnapshot = await _companyDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData = iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? companyData = companySnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && companyData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && companyData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String companyName = companyData[key]['Company Name'] ?? '';
            String zone = companyData[key]['Zone'] ?? '';

            UserData userData = UserData(
              matric: matric, 
              name: name, 
              companyName: companyName, 
              zone: zone);
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
        title: const Text('List of Students'),
        centerTitle: true,
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
                      Text('Company: ${_userData[index].companyName}'),
                      Text('Zone: ${_userData[index].zone}'),
                    ],
                  ),
                  // onTap: () {
                  //   // Add onTap functionality if needed
                  // },
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
  final String companyName;
  final String zone;

  UserData({required this.matric, required this.name, required this.companyName, required this.zone});
}
