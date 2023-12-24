
import 'package:flutter/material.dart';

class CombinedTabBarAndDrawer extends StatefulWidget {
  const CombinedTabBarAndDrawer({Key? key}) : super(key: key);

  @override
  State<CombinedTabBarAndDrawer> createState() =>
      _CombinedTabBarAndDrawerState();
}

class _CombinedTabBarAndDrawerState extends State<CombinedTabBarAndDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
   late PageController _pageController;
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _pageController = PageController();
    //_tabController.addListener(_onTabChanged);
  }

/*  void _onTabChanged() {
    if (_tabController.index != _pageController.page!.round()) {
      _pageController.animateToPage(
        _tabController.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }*/

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onDrawerItemSelected(int index) {
    setState(() {
      _selectedDrawerIndex = index;
      _tabController.animateTo(index);
      _pageController.jumpToPage(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Combined TabBar and Drawer'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          tabs: const [
            Tab(text: "Dashboard"),
            Tab(text: "Applications"),
            Tab(text: "Examiner"),
            Tab(text: "Placement"),
            Tab(text: "Final Report"),
            Tab(text: "Result"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 146, 143, 10),
            ),
            child: Text('i-KICT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Futura')),
          ),
        
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
           iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Dashboard'),
            onTap: () => _onDrawerItemSelected(0),
              selected: _selectedDrawerIndex == 0,
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_sharp),
            iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Industrial Attachment Programme'),
           onTap: () => _onDrawerItemSelected(1),
              selected: _selectedDrawerIndex == 1,
          ),
           ListTile(
            leading: const Icon(Icons.list_alt_rounded),
             iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Student List'),
             onTap: () => _onDrawerItemSelected(2),
              selected: _selectedDrawerIndex == 2,
          ),
          ListTile(
            leading: const Icon(Icons.edit_document),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('IAP Form'),
             onTap: () => _onDrawerItemSelected(3),
              selected: _selectedDrawerIndex == 3,
          ),
          ListTile(
            leading: const Icon(Icons.details_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Placement Details'),
             onTap: () => _onDrawerItemSelected(4),
              selected: _selectedDrawerIndex == 4,
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_rounded),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Supervisor Details'),
             onTap: () => _onDrawerItemSelected(5),
              selected: _selectedDrawerIndex == 5,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
           iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Quit'),
             onTap: () => _onDrawerItemSelected(6),
              selected: _selectedDrawerIndex == 6,
          ),
          ],
        ),
      ),
        body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          if (_tabController.index != index) {
            _tabController.animateTo(index);
          }
          setState(() {
            _selectedDrawerIndex = index;
          });
        },
        children: const [
          Center(child: Text('Dashboard Content')),
          Center(child: Text('Applications Content')),
          Center(child: Text('Examiner Content')),
          Center(child: Text('Placement Content')),
          Center(child: Text('Final Report Content')),
          Center(child: Text('Result Content')),
        ],
      ),
    );
  }
}