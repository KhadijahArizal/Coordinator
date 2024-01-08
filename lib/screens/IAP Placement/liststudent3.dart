import 'package:coordinator/screens/IAP%20Placement/placement.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserData {
  final String matric;
  final String name;
  final String comname;
  final String zone;
  final String address;
  final String postcode;
  final String industry;
  final String allowance;
  final String duration;
  final String sector;
  final String start;
  final String end;
  final String offer;
  String status;
  final String studentID;
  final Function(String) onActive;
  final Function(String) onInactive;

  UserData({
    required this.matric,
    required this.name,
    required this.comname,
    required this.zone,
    required this.address,
    required this.postcode,
    required this.industry,
    required this.allowance,
    required this.duration,
    required this.sector,
    required this.start,
    required this.end,
    required this.offer,
    required this.status,
    required this.onActive,
    required this.onInactive,
    required this.studentID,
  });
}

class ListStudent3 extends StatefulWidget {
  const ListStudent3({Key? key}) : super(key: key);

  @override
  State<ListStudent3> createState() => _ListStudent3State();
}

class _ListStudent3State extends State<ListStudent3> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _companyDetailsRef;
  late Future<List<UserData>> _userFinalFuture;
  String status = '';

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _companyDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Company Details');
    _userFinalFuture = _fetchFinalData();
  }

  Future<List<UserData>> _fetchFinalData() async {
    List<UserData> userDataList = [];
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot companySnapshot =
          await _companyDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? companyData =
          companySnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && companyData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && companyData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            String name = value['Name'] ?? '';
            String comname = companyData[key]['Company Name'] ?? '';
            String zone = companyData[key]['Zone'] ?? '';
            String address = companyData[key]['Address'] ?? '';
            String postcode = companyData[key]['Postcode'] ?? '';
            String industry = companyData[key]['Industry'] ?? '';
            String allowance = companyData[key]['Monthly Allowance'] ?? '';
            String duration = companyData[key]['Duration'] ?? '';
            String sector = companyData[key]['Sector'] ?? '';
            String start = companyData[key]['Start Date'] ?? '';
            String end = companyData[key]['End Date'] ?? '';
            String offer = companyData[key]['Offer Letter'] ?? '';
            String status = companyData['Status'] ?? '';
            String studentID = key as String? ?? '';

            UserData user = UserData(
              matric: matric,
              name: name,
              comname: comname,
              zone: zone,
              address: address,
              postcode: postcode,
              industry: industry,
              allowance: allowance,
              duration: duration,
              sector: sector,
              start: start,
              end: end,
              offer: offer,
              status: status,
              studentID: studentID,
              onActive: (String) {},
              onInactive: (String) {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
        centerTitle: true,
        title: const Text(
          'Placement',
        ),
      ),
      drawer: NavBar(),
      body: Container(
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
          //border: Border.all(color: Colors.black), // Add a border
          borderRadius: BorderRadius.circular(10.0), // Add border radius
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5), // Add shadow color
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin:
            const EdgeInsets.only(top: 20), // Adjust the top margin as needed
        child: FutureBuilder<List<UserData>>(
          future: _userFinalFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available.'));
            } else {
              return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Matric No')),
                      DataColumn(label: Text('Student Name')),
                      DataColumn(label: Text('Company')),
                      DataColumn(label: Text('Zone')),
                    ],
                    rows: snapshot.data!.map((user) {
                      return DataRow(cells: [
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlacementDetails(
                                    matric: user.matric,
                                    comname: user.comname,
                                    zone: user.zone,
                                    address: user.address,
                                    postcode: user.postcode,
                                    industry: user.industry,
                                    allowance: user.allowance,
                                    duration: user.duration,
                                    sector: user.sector,
                                    start: user.start,
                                    end: user.end,
                                    offer: user.offer,
                                    status: user.status,
                                    studentID: user.studentID,
                                    onActive: (String) {},
                                    onInactive: (String) {},
                                    onUpdateStatus: (String) {},
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              user.matric,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Colors.green, // Set underline color to blue
                                decorationThickness: 2.0,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(user.name)),
                        DataCell(Text(user.comname)),
                        DataCell(
                          Text(user.zone,),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
