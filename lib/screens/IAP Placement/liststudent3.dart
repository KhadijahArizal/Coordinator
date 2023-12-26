import 'package:coordinator/screens/IAP%20Placement/placement.dart';
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
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _companyDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Company Details');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
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

            UserData userData = UserData(
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
        title: const Text('List of Students Placement'),
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
                                    Text('Name: ${_userData[index].name}'),
                                    Text('Company: ${_userData[index].comname}'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Zone: ${_userData[index].zone}'),
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
                              builder: (context) => PlacementDetails(
                                matric: _userData[index].matric,
                                comname: _userData[index].comname,
                                zone: _userData[index].zone,
                                address: _userData[index].address,
                                postcode: _userData[index].postcode,
                                industry: _userData[index].industry,
                                allowance: _userData[index].allowance,
                                duration: _userData[index].duration,
                                sector: _userData[index].sector,
                                start: _userData[index].start,
                                end: _userData[index].end,
                                offer: _userData[index].offer,
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
  });
}
