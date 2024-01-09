import 'package:coordinator/screens/IAP%20Emergency/emergency.dart';
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
  late DatabaseReference _emergencyDetailsRef;
  late List<UserData> _userData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _emergencyDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Emergency Details');
    _fetchUserData();
  }

 List<UserData> _filterUserData(String searchValue) {
    return _userData
        .where((user) =>
            user.matric.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
  }


  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot emergencySnapshot =
          await _emergencyDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? emergencyData =
          emergencySnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && emergencyData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && emergencyData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String emergname = emergencyData[key]['Name'] ?? '';
            String contact = emergencyData[key]['Emergency Contact Person'] ?? '';
            String relay = emergencyData[key]['Relationship'] ?? '';
            String homeadd = emergencyData[key]['Home Address'] ?? '';
            
            UserData userData = UserData(
              matric: matric,
              name: name,
              emergname: emergname,
              contact: contact,
              relay: relay,
              homeadd: homeadd,

              
             
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
        title: const Text(
          'Emergency Contact',
        ),
      ),
       drawer: NavBar(),
    body: Stack(
        children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('images/iiumlogo.png'), // Add your desired image
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
         Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Matric')),
                      DataColumn(label: Text('Student Name')),
                      DataColumn(label: Text('Emergency Person Name')),
                      DataColumn(label: Text('Contact')),
                      DataColumn(label: Text('Relationship')), // New column
                      DataColumn(label: Text('Home Address')), // New column
                    ],
                    rows: _userData.map((userData) {
                      return DataRow(cells: [
                         DataCell(
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmergencyDetails(
                                    matric: userData.matric,
                                    emergname: userData.emergname,
                                    relay: userData.relay,
                                    contact: userData.contact,
                                    homeadd: userData.homeadd,
                                   
                                  
                                  ),
                                ),
                              );
                            },
                            child: Text(
                                  userData.matric,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromRGBO(76, 175, 80, 1), // Change underline color if needed
                                  ),
                                ),
                              ),
                            ),
                        DataCell(Text(userData.name)),
                        DataCell(Text(userData.emergname)),
                        DataCell(Text(userData.contact)),
                        DataCell(Text(userData.relay)), // New cell
                        DataCell(Text(userData.homeadd)), // New cell
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) // Conditionally show CircularProgressIndicator
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class UserData {
  final String matric;
  final String name;
  final String emergname;
  final String contact;
  final String relay;
  final String homeadd;

  UserData({
    required this.matric,
    required this.name,
    required this.emergname,
    required this.contact,
    required this.relay,
    required this.homeadd,
  });
}