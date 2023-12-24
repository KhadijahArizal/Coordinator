

import 'package:coordinator/screens/IAP%20Placement/placement.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ListStudent3 extends StatefulWidget {
  const ListStudent3({Key? key}) : super(key: key);

  @override
  State<ListStudent3> createState() => _ListStudent3State();
}

class _ListStudent3State extends State<ListStudent3> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Company Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('List of Industrial Attachment Programme Student (Company Details)'),  
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
                      final zone = snapshot.child('Zone').value.toString();
                      final comname = snapshot.child('Company Name').value.toString();
                      final address = snapshot.child('Address').value.toString();
                      final postcode = snapshot.child('Postcode').value.toString();
                      final industry = snapshot.child('Industry').value.toString();
                      final allowance = snapshot.child('Monthly Allowance').value.toString();
                      final duration = snapshot.child('Duration').value.toString();
                      final sector = snapshot.child('Sector').value.toString();
                      final start = snapshot.child('Start Date').value.toString();
                      final end = snapshot.child('End Date').value.toString();
                      final offer = snapshot.child('Offer Letter').value.toString();



                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlacementDetails(
                          zone: zone,
                          comname: comname,
                          address: address,
                          postcode: postcode,
                          industry: industry,
                          allowance: allowance,
                          duration: duration,
                          sector: sector,
                          start: start,
                          end: end,
                          offer: offer,

                          ),
                      ));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            snapshot.child('Company Name').value.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          title: Text(snapshot.child('Zone').value.toString()),
                          trailing: Text(snapshot.child('Industry').value.toString()),
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

