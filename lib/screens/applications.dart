

import 'package:coordinator/screens/navbar.dart';
import 'package:coordinator/screens/tabsbar.dart';
import 'package:flutter/material.dart';


class Applications extends StatefulWidget {
 
 
  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     //drawer:  NavBar(),
     appBar: AppBar(
      title: const Text('IAP Applications'),
      backgroundColor: const Color.fromRGBO(148, 112, 18, 1),
    ),
    body: const Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'IAP Applications'
          ),
        ],
        ),
        ),
     //drawer:  NavBar(),
   
   );
    
  }
}