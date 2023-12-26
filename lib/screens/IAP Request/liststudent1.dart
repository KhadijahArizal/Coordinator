import 'package:coordinator/screens/IAP%20Request/iapform.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
  });
}

class ListStudent1 extends StatefulWidget {
  const ListStudent1({Key? key}) : super(key: key);

  @override
  State<ListStudent1> createState() => _ListStudent1State();
}

class _ListStudent1State extends State<ListStudent1> {
  late DatabaseReference _ref;
  late Future<DataSnapshot> _dataSnapshotFuture;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _dataSnapshotFuture = _fetchData();
  }

  Future<DataSnapshot> _fetchData() async {
    try {
      DatabaseEvent event = await _ref.once();
      return event.snapshot;
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Students'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),

      ),
      drawer: NavBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 20), // Adjust the top margin as needed
        child:FutureBuilder<DataSnapshot>(
        future: _dataSnapshotFuture,
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data?.value == null) {
            return const Center(
              child: Text('No data available.'),
            );
          } else {
            DataSnapshot dataSnapshot = snapshot.data!;
            Map<dynamic, dynamic>? userData =
                dataSnapshot.value as Map<dynamic, dynamic>?;

            List<UserData> userTiles = [];

            if (userData != null) {
              userData.forEach((key, value) {
                // Process each user's data and create UserData objects accordingly
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
                    partial: partial,
                    graduation: graduation,
                    confirmation: confirmation,
                  );
                  userTiles.add(user);
                }
              });
            }

             return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView(
              children: userTiles.isNotEmpty
                  ? userTiles.map((user) {
                      return Column(
                        children: [
                          InkWell(
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
                                    // Pass other fields as needed
                                  ),
                                ),
                              );
                            },
                            child: Center(
                                  child: SizedBox(
                                    height: 70, // Adjust the height as needed
                                    child: Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(user.matric),
                                                Text(user.name),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(user.major),
                                                // Add other fields as needed
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10), // Add spacing between items
                            ],
                          );
                        }).toList()
                      : [const Center(child: Text('No valid data found.'))],
                ),
              ),
            );
          }
        },
      ),
     ) );
  }
}