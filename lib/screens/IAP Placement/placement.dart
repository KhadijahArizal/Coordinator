
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PlacementDetails extends StatefulWidget {
  const PlacementDetails({Key? key}) : super(key: key);

  @override
  State<PlacementDetails> createState() => _PlacementDetailsState();
}

class _PlacementDetailsState extends State<PlacementDetails> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Student').child('Company Details');
  @override

  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
        title: const Text('Placement Details'),  
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
                              'Zone: ',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              snapshot.child('Zone').value.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                //decoration: TextDecoration.underline,
                              
                              ),
                            ),
                          ],
                          
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Company Name: ${snapshot.child('Company Name').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        //const SizedBox(height: 8.0),
                        Text(
                          'Address: ${snapshot.child('Address').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Postcode: ${snapshot.child('Postcode').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Industry: ${snapshot.child('Industry').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Monthly Allowance: ${snapshot.child('Monthly Allowance').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Duration: ${snapshot.child('Duration').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Sector: ${snapshot.child('Sector').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Start Date: ${snapshot.child('Start Date').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'End Date: ${snapshot.child('End Date').value.toString()}',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Offer Letter: ${snapshot.child('Offer Letter').value.toString()}',
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