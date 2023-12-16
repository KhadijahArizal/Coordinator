
import 'package:coordinator/screens/navbar.dart';
import 'package:coordinator/screens/tabsbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoverLetter extends StatelessWidget {
  const CoverLetter({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: const IconThemeData(
              color: Color.fromRGBO(148, 112, 18, 1), size: 30)),
      drawer: const nav_bar(),
      
      
      body:SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: const AssetImage('assets/images/iium.png'),
            //fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white30.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
   
     
    )));
  }
}
