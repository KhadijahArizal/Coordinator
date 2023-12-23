


import 'package:coordinator/screens/IAP%20Student%20Details/studentdetails.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class EmergencyDetails extends StatefulWidget {
  const EmergencyDetails({Key? key}) : super(key: key);

  @override
  State<EmergencyDetails> createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Emergency Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
        title: const Text('Emergency Details'),  
        centerTitle: true,      
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
     drawer: NavBar(),
      body: Column(
        children: [
          const SizedBox(height: 20.0,),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(200.0, 0, 200.0, 0),
                  
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              snapshot.child('Name').value.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                //decoration: TextDecoration.underline,
                              
                              ),
                            ),
                          ],
                          
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Relationship: ${snapshot.child('Relationship').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Home Address: ${snapshot.child('Home Address').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Emergency Contact Person: ${snapshot.child('Emergency Contact Person').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        
                        
                        const Divider(color: Colors.black),
                      ],
                    ),
                  );
              },
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentDetails()), 
              );
            },
            child: const Text('Return'),
          ),
        ],
      ),
    );
  }
}