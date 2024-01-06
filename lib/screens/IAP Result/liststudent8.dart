import 'package:coordinator/screens/IAP%20Result/generatecsv.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData {
  final String matric;
  final String name;
  //final String email;
  final String major;
  final String uid;

  UserData({
    required this.matric,
    required this.name,
    //required this.email,
    required this.major,
    required this.uid,
  });
}

class ListStudent8 extends StatefulWidget {
  const ListStudent8({Key? key}) : super(key: key);

  @override
  State<ListStudent8> createState() => _ListStudent8State();
}

class _ListStudent8State extends State<ListStudent8> {
  late DatabaseReference _ref;
  late Future<DataSnapshot> _dataSnapshotFuture;
  List<UserData> userTiles = []; 
  

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

 Future<void> downloadExcel(List<UserData> users) async {
  try {
    await GenerateExcel.downloadExcel(users , context); // Adjust this call if context is not needed here
  } catch (e) {
    // Handle any potential errors
    print('Error downloading Excel: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student IAP Result'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
        toolbarHeight: 60.0,
      ),
      drawer: NavBar(),
      body: Container(
        margin:
            const EdgeInsets.only(top: 10), // Adjust the top margin as needed
        child: FutureBuilder<DataSnapshot>(
          future: _dataSnapshotFuture,
          builder:
              (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
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
                    // String email = value['Email'] ?? '';
                    String major = value['Major'] ?? '';
                    String uid = value['uid'] ?? '';

                    UserData user = UserData(
                      matric: matric,
                      name: name,
                      //email: email,
                      major: major,
                      uid: uid,
                    );
                    userTiles.add(user);
                  }
                });
              }

              return Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Matric No')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Major')),
                              DataColumn(
                                  label: Text('Supervisor'), numeric: true),
                              DataColumn(
                                  label: Text('Examiner'), numeric: true),
                              DataColumn(
                                  label: Text('Coordinator'), numeric: true),

                              // Add more columns as needed for marks distribution
                            ],
                            rows: userTiles.map((user) {
                              return DataRow(cells: [
                                DataCell(Text(user.matric)),
                                DataCell(Text(user.name)),
                                DataCell(Text(user.major)),
                                DataCell(
                                  Container(
                                    width:
                                        50, // Set the desired width for the TextFormField
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Marks',
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (double.tryParse(value) == null) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Invalid Input'),
                                                  content: const Text(
                                                      'Please enter a valid numeric value.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                        // Handle other logic based on your requirements
                                      },
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width:
                                        50, // Set the desired width for the TextFormField
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: 'Marks',
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (double.tryParse(value) == null) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Invalid Input'),
                                                  content: const Text(
                                                      'Please enter a valid numeric value.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                        // Handle other logic based on your requirements
                                      },
                                    ),
                                  ),
                                ),
                                DataCell(Container(
                                  width:
                                      50, // Set the desired width for the TextFormField
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Marks',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        if (double.tryParse(value) == null) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Invalid Input'),
                                                content: const Text(
                                                    'Please enter a valid numeric value.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      }
                                      // Handle other logic based on your requirements
                                    },
                                  ),
                                )),
                                // Repeat similar TextFormField for Examiner and Supervisor marks
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            List<UserData> users = _ListStudent8State().userTiles;

          // Adjusting the method call with required arguments
          GenerateExcel.downloadExcel(users, context);
                          },
                          child: const Text('Download'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
