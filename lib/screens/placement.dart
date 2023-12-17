

import 'package:coordinator/screens/navbar.dart';
import 'package:flutter/material.dart';


class Placement extends StatefulWidget {
  const Placement ({super.key});
 
  @override
  State<Placement > createState() => _PlacementState();
}

class _PlacementState extends State<Placement > {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer:  NavBar(),
    appBar: AppBar(
      title: const Text('Placement'),
      backgroundColor: const Color.fromRGBO(148, 112, 18, 1),
    ),
    body: const Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Placement '
          ),
        ],
        ),
        ),
   );
    
  }
}