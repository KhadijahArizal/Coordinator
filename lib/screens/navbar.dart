import 'package:coordinator/screens/IAP%20Placement/supervisor.dart';
import 'package:coordinator/screens/IAP%20Request/iapform.dart';
import 'package:coordinator/screens/IAP%20Student%20Details/liststudent.dart';
import 'package:coordinator/screens/IAP%20Placement/placement.dart';
import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/navbar2.dart';
import 'package:coordinator/screens/start.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  //const NavBar ({super.key});
  //({required Key key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
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
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.align_vertical_bottom),
           iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('TEST'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavBar2(
                          )))
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_rounded),
           iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Dashboard'),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Dashboard(
                            title: '',
                          )))
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_sharp),
            iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Industrial Attachment Programme'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavBar()))
            },
          ),
           ListTile(
            leading: const Icon(Icons.list_alt_rounded),
             iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Student List'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_document),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('IAP Form'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const IAPForm()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.details_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Placement Details'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const PlacementDetails()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_alt_rounded),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Supervisor Details'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const SupervisorDetails()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
           iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Quit'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          ),
     
         /* TextButton(
           style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
           ),
           onPressed: _isProcessing
           ? null
           : () async {
            setState(() {
              _isProcessing = true;
            });
            await signOut().then((result) {
              print(result);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                  builder: (context) => HomePage(),
                              ),
                              );
                        
                      }).catchError((error) {
                        print('error: $error');
                      });
                      setState(() {
                        _isProcessing = false;
                      });
                     }, */
          
      
           ]));
           }
           }
