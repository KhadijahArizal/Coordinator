


import 'package:coordinator/screens/IAP%20Student%20Details/liststudent.dart';
import 'package:coordinator/screens/IAP%20Student%20Details/studentdetails.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class IAPForm extends StatefulWidget {
  const IAPForm({Key? key}) : super(key: key);

  @override
  State<IAPForm> createState() => _IAPFormState();
}

class _IAPFormState extends State<IAPForm > {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('IAP Form');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
        title: const Text('Student IAP Form'),  
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
                              'Matric No: ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              snapshot.child('Matric').value.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                //decoration: TextDecoration.underline,
                              
                              ),
                            ),
                          ],
                          
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Student Name: ${snapshot.child('Name').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Matric No: ${snapshot.child('Matric').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Email: ${snapshot.child('Email').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Major: ${snapshot.child('Major').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Admission Type: ${snapshot.child('Admission Type').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Univ Required Course: ${snapshot.child('Univ Required Course').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Department Required Course: ${snapshot.child('Department Required Course').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Kulliyyah Required Course: ${snapshot.child('Kulliyyah Required Course').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Department Elective Course: ${snapshot.child('Department Elective Course').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'CH Current Sem: ${snapshot.child('CH Current Sem').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Total CH: ${snapshot.child('Total CH').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Semester: ${snapshot.child('Semester').value.toString()}',
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
            child: const Text('Student Details'),
          ),
            const SizedBox(height: 20.0),
           ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListStudent()), 
              );
            },
            child: const Text('Return'),
          ),
        ],
      ),
    );
  }
}