

import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class SupervisorDetails extends StatefulWidget {
  const SupervisorDetails({Key? key}) : super(key: key);

  @override
  State<SupervisorDetails> createState() => _SupervisorDetailsState();
}

class _SupervisorDetailsState extends State<SupervisorDetails> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Supervisor Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
        title: const Text('Supervisor Details'),  
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
                              'Supervisor Name: ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              snapshot.child('Supervisor Name').value.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                //decoration: TextDecoration.underline,
                              
                              ),
                            ),
                          ],
                          
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Contact No: ${snapshot.child('Contact No').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Email: ${snapshot.child('Email').value.toString()}',
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