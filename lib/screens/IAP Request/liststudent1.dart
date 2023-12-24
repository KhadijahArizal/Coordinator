
import 'package:coordinator/screens/IAP%20Request/iapform.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListStudent1 extends StatefulWidget {
  const ListStudent1({Key? key}) : super(key: key);

  @override
  State<ListStudent1> createState() => _ListStudent1State();
}

class _ListStudent1State extends State<ListStudent1> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('IAP Form');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('List of Industrial Attachment Programme Student (IAP Form)'),  
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
                      final matric = snapshot.child('Matric').value.toString();
                      final name = snapshot.child('Name').value.toString();
                      final email = snapshot.child('Email').value.toString();
                      final major = snapshot.child('Major').value.toString();
                      final admission = snapshot.child('Admission Type').value.toString();
                      final univ = snapshot.child('Univ Required Course').value.toString();
                      final department = snapshot.child('Department Required Course').value.toString();
                      final kulliyyah = snapshot.child('Kulliyyah Required Course').value.toString();
                      final elective = snapshot.child('Department Elective Course').value.toString();
                      final ch = snapshot.child('CH Current Sem').value.toString();
                      final total = snapshot.child('Total CH').value.toString();
                      final semester = snapshot.child('Semester').value.toString();



                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => IAPForm(
                          matric: matric, 
                          name: name, 
                          email: email,
                          major: major,
                          admission: admission,
                          univ: univ,
                          department: department,
                          kulliyyah: kulliyyah,
                          elective: elective,
                          ch: ch,
                          total: total,
                          semester: semester,

                          ),
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            snapshot.child('Matric').value.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          title: Text(snapshot.child('Name').value.toString()),
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

