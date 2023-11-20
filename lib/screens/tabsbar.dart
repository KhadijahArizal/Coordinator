import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coordinator/screens/navbar.dart';

class tabBarIAP extends StatelessWidget {
  const tabBarIAP({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(useMaterial3: true),
      //home: tabBarIAP(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TabBars extends StatefulWidget {
  const TabBars({super.key});

  @override
  State<TabBars> createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IAP Students'),
        backgroundColor: const Color.fromRGBO(148, 112, 18, 1),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
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
      drawer: const nav_bar(),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
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
    );
  }
}