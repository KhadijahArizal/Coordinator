

import 'package:coordinator/screens/navbar.dart';
import 'package:flutter/material.dart';


class CoverLetter extends StatefulWidget {
  const CoverLetter({super.key});
 
  @override
  State<CoverLetter> createState() => _CoverLetterState();
}

class _CoverLetterState extends State<CoverLetter> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     drawer:  NavBar(),
    appBar: AppBar(
      title: const Text('Cover Letter'),
      backgroundColor: const Color.fromRGBO(148, 112, 18, 1),
    ),
    body: const Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Cover Letter'
          ),
        ],
        ),
        ),
   );
    
  }
}