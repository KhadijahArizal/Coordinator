
import 'package:coordinator/screens/applications.dart';
import 'package:coordinator/screens/coverletter.dart';
import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/placement.dart';
import 'package:coordinator/screens/tabsbar.dart';

import 'package:flutter/material.dart';


class NavBar extends StatefulWidget {
  //const NavBar ({super.key});
  //({required Key key}) : super(key: key);
 
 @override
 State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.amberAccent,
        child: ListView(
          children: [
            const DrawerHeader(
               decoration: BoxDecoration(
                    color: Color.fromRGBO(148, 112, 18, 10),
                  ),
                  child: Text('i-KICT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Futura')),
                ),
                const SizedBox(
                  height: 10,
                ),
                 ListTile(
              leading: Icon(Icons.dashboard_rounded),
              title: Text('Dashboard'),
            onTap: () =>{ Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dashboard(title: '',)))
            },
            ),
            ListTile(
              leading: Icon(Icons.app_registration_sharp),
              title: Text('IAP Applications'),
            onTap: () =>{ Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabBars()))
            },
            ),
            ListTile(
              leading: Icon(Icons.request_page),
              title: Text('Cover Letter Request'),
            onTap: () =>{ Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabBars()))
            },
            ),
            ListTile(
              leading: Icon(Icons.approval_sharp),
              title: Text('Placement Verification'),
            onTap: () =>{ Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabBars()))
            },
            ),
            
            ],
            ),
        );
    
    

      
  }
}

