
import 'package:coordinator/screens/navbar.dart';
import 'package:flutter/material.dart';



class TabBars extends StatelessWidget {
  const TabBars({super.key});


  @override
  Widget build(BuildContext context) {
   
return DefaultTabController(
  length: 3,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('IAP Students'),
        backgroundColor: const Color.fromRGBO(148, 112, 18, 1),
        bottom: const TabBar(
          //controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'IAP Application Request',
            ),
            Tab(
              text: 'Cover Letter Request',
            ),
            Tab(
              text: 'Student Placement Request',
            ),
          ],
        ),
      ),
      drawer: NavBar(),
            body: const TabBarView(
        //controller: _tabController,
        children: <Widget>[
          Center(
            child: Text("IAP Application Request"),
          ),
          Center(
            child: Text("Cover Letter Request"),
          ),
          Center(
            child: Text("Student Placement Request"),
                    ),
        ],
      ),
    ));
  }
}

