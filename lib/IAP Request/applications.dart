import 'package:flutter/material.dart';

class Applications extends StatefulWidget {
  const Applications({Key? key}) : super(key: key);
  

  @override
  _ApplicationsState createState() => _ApplicationsState();
}


class _ApplicationsState extends State<Applications>
with SingleTickerProviderStateMixin{

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


List<Tab> items = [
   const Tab(text: "Dashboard"),
    const Tab(text: "Applications"),
    const Tab(text:"Examiner"),
    const Tab(text:"Placement"),
    const Tab(text:"Final Report"),
    const Tab(text:"Result"),
   
];

List<Widget> view = [
  const ReusableTabBarWidget(title: "Dashboard"),
  const ReusableTabBarWidget(title: "Applications"),
  const ReusableTabBarWidget(title: "Examiner"),
  const ReusableTabBarWidget(title: "Placement"),
  const ReusableTabBarWidget(title: "Final Report"),
  const ReusableTabBarWidget(title: "Result"),
];

int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
           Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    right: 16.0,
                    left: 16.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)
                    ),
                  ),
                child: TabBar(
                  controller: _tabController,
                  tabs: items,
                  labelColor: Colors.white,
                  indicatorColor: Colors.teal.shade900,
                  unselectedLabelColor: Colors.grey.shade700,
                  indicator: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                    color: Colors.teal.shade900,
                     ),
                  indicatorSize: TabBarIndicatorSize.tab,

                  ),
                )
              ]
              .map((e) => Column(
                children: [
                  e,
                  const Divider(
                    color: Colors.transparent,
                  )
                ],
              )
              )
              .toList(),
              )),
              Expanded(
              child: TabBarView(
                controller: _tabController,
              children: view,))   
            ],)),)
          );
          
  }
}

class ReusableTabBarWidget extends StatelessWidget{
  const ReusableTabBarWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
       ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title'
          
          ),
        ]),
    );
  }
}