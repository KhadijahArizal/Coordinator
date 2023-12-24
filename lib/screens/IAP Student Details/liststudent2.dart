

import 'package:coordinator/screens/IAP%20Student%20Details/studentdetails.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListStudent2 extends StatefulWidget {
  const ListStudent2({Key? key}) : super(key: key);

  @override
  State<ListStudent2> createState() => _ListStudent2State();
}

class _ListStudent2State extends State<ListStudent2> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Student Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('List of Industrial Attachment Programme Student (Personal Details)'),  
        centerTitle: true,      
        toolbarHeight: 200,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      drawer: NavBar(),
  
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(200.0, 20.0, 200.0, 20.0),
                  child: GestureDetector(
                    onTap: () {
                      final matric = snapshot.child('Matric No').value.toString();
                      final salutation = snapshot.child('Salutation').value.toString();
                      final name = snapshot.child('Student Name').value.toString();
                      final major = snapshot.child('Major').value.toString();
                      final ic = snapshot.child('IC or Passport').value.toString();
                      final email = snapshot.child('Email').value.toString();
                      final contactno = snapshot.child('Contact No').value.toString();
                      final citizenship = snapshot.child('Citizenship').value.toString();
                      final address = snapshot.child('Address').value.toString();
                      


                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StudentDetails(
                          matric: matric, 
                          salutation: salutation,
                          name: name, 
                          major: major,
                          ic: ic,
                          email: email,
                          contactno: contactno,
                          citizenship: citizenship,
                          address: address,

                          ),
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            snapshot.child('Matric No').value.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          title: Text(snapshot.child('Student Name').value.toString()),
                          trailing: Text(snapshot.child('Major').value.toString()),
                        ),
                        const Divider(color: Colors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

