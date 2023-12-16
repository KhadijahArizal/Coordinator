import 'package:coordinator/screens/applications.dart';
import 'package:coordinator/screens/coverletter.dart';
import 'package:coordinator/screens/placement.dart';
import 'package:flutter/material.dart';


class TabBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: 'applications',
                ),
                Tab(
                  text: 'applications',
                ),
                Tab(
                  text: 'applications',
                ),
                Tab(
                  text: 'applications',
                ),
              ],
            ),
          Expanded(child: TabBarView(children: [
            
            Applications(),
            CoverLetter(),
            Placement(),

          ]))
          ],
        ),
      ),
    );
  }
}

