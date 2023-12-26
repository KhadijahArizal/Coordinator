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
        title: const Text('List of Supervisor'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
       drawer: NavBar(),
    body: Center(
      child: _userData.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 2.0), // Adjust the top padding as needed
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Matric: ${_userData[index].matric}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Student Name: ${_userData[index].name}'),
                                    //Text('Supervisor Name: ${_userData[index].comname}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Supervisor Name: ${_userData[index].svname}'),
                                    // Add more details as needed
                                  ],
                                ),
                              ],
                            ),
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
                      ),
                    );
                  },
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
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
