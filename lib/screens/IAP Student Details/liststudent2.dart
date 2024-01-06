import 'package:coordinator/screens/IAP%20Student%20Details/studentdetails.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListStudent2 extends StatefulWidget {
  const ListStudent2({Key? key}) : super(key: key);

  @override
  State<ListStudent2> createState() => _ListStudent2State();
}

class _ListStudent2State extends State<ListStudent2> {
  late DatabaseReference _iapFormRef;
  late DatabaseReference _studentDetailsRef;
  late List<UserData> _userData = [];
   bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _iapFormRef =
        FirebaseDatabase.instance.ref().child('Student').child('IAP Form');
    _studentDetailsRef = FirebaseDatabase.instance
        .ref()
        .child('Student')
        .child('Student Details');
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DataSnapshot iapSnapshot =
          await _iapFormRef.once().then((event) => event.snapshot);
      DataSnapshot studentSnapshot =
          await _studentDetailsRef.once().then((event) => event.snapshot);

      Map<dynamic, dynamic>? iapData =
          iapSnapshot.value as Map<dynamic, dynamic>?;
      Map<dynamic, dynamic>? studentData =
          studentSnapshot.value as Map<dynamic, dynamic>?;

      if (iapData != null && studentData != null) {
        iapData.forEach((key, value) {
          if (value is Map<dynamic, dynamic> && studentData.containsKey(key)) {
            String matric = value['Matric'] ?? '';
            //String salutation = value['Salutation'] ?? '';
            String name = value['Name'] ?? '';
            String major = studentData[key]['Major'] ?? '';
            String ic = studentData[key]['IC or Passport'] ?? '';
            String email = studentData[key]['Email'] ?? '';
            String contactno = studentData[key]['Contact No'] ?? '';
            String citizenship = studentData[key]['Citizenship'] ?? '';
            String address = studentData[key]['Address'] ?? '';
            

            UserData userData = UserData(
              matric: matric,
              //salutation: salutation,
              name: name,
              major: major,
              ic: ic,
              email: email,
              contactno: contactno,
              citizenship: citizenship,
              address: address,
              
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
          'Student Details',
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
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Major: ${_userData[index].major}'),
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
                              builder: (context) => StudentDetails(
                            matric: _userData[index].matric,
                            //salutation: _userData[index].salutation,
                            name: _userData[index].name,
                            major: _userData[index].major,
                            ic: _userData[index].ic,
                            email: _userData[index].email,
                            contactno: _userData[index].contactno,
                            citizenship: _userData[index].citizenship,
                            address: _userData[index].address,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (_isLoading) // Conditionally show CircularProgressIndicator
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
class UserData {
  final String matric;
  //final String salutation;
  final String name;
  final String major;
  final String ic;
  final String email;
  final String contactno; 
  final String citizenship; 
  final String address; 

  UserData({
    required this.matric,
   //required this.salutation,
    required this.name,
    required this.major,
    required this.ic,
    required this.email,
    required this.contactno,
    required this.citizenship,
    required this.address,
  });
}