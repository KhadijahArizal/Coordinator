import 'package:coordinator/screens/IAP%20Request/fullliststudent.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('IAP Form');
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
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot,animation, index){
                return Padding(
                  padding: const EdgeInsets.fromLTRB(200.0, 20.0, 200.0, 20.0), 
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FullListStudent(), 
                      ));
                    },
                  child: Column(
                    children: [
                    ListTile(
                      leading: Text(snapshot.child('Matric').value.toString(),
                       style: const TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.underline,
                              
                              ),),
                      title: Text(snapshot.child('Name').value.toString()),
                      trailing: Text(snapshot.child('Major').value.toString()),
                    ),
                    const Divider(color: Colors.black),
                  ],
                
                ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}





