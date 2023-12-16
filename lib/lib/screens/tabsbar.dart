import 'package:coordinator/screens/applications.dart';
import 'package:coordinator/screens/coverletter.dart';
import 'package:coordinator/screens/placement.dart';
import 'package:flutter/material.dart';

class tab_bar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //title: const Text('IAP Dashboard'),
       bottom:const TabBar(
        indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(
                  icon: Icon(Icons.label_important,
                      color: Color.fromRGBO(148, 112, 18, 1)),
                  text: 'IAP Applications',
                ),
                Tab(
                  icon: Icon(Icons.label_important,
                      color: Color.fromRGBO(148, 112, 18, 1)),
                  text: 'Cover Letter Request',
                ),
                Tab(
                  icon: Icon(Icons.label_important,
                      color: Color.fromRGBO(148, 112, 18, 1)),
                  text: 'Placement  Verification',
                ),
               
              ],
            ),
        ),
            body: const TabBarView(
            children: [
              Applications(),
              CoverLetter(),
              Placement(),
            ]
            ),
            ),
        
        );
   
  }
}
