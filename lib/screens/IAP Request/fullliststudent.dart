import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FullListStudent extends StatefulWidget {
  const FullListStudent({Key? key}) : super(key: key);

  @override
  State<FullListStudent> createState() => _FullListStudentState();
}

class _FullListStudentState extends State<FullListStudent> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Student Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('List of Industrial Attachment Programme Student'),  
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
                              snapshot.child('Matric No').value.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                //decoration: TextDecoration.underline,
                              
                              ),
                            ),
                          ],
                          
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Salutation: ${snapshot.child('Salutation').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Student Name: ${snapshot.child('Student Name').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Matric No: ${snapshot.child('Matric No').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Major: ${snapshot.child('Major').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'IC/Passport: ${snapshot.child('IC or Passport').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Email: ${snapshot.child('Email').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Contact No: ${snapshot.child('Contact No').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Citizenship: ${snapshot.child('Citizenship').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Address: ${snapshot.child('Address').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      
                        const Divider(color: Colors.black),
                      ],
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}