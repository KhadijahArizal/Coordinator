
import 'package:coordinator/screens/dashboard.dart';
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
            leading: const Icon(Icons.dashboard_rounded),
            iconColor: const Color.fromRGBO(148, 112, 18, 10),
          
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
             iconColor: const Color.fromRGBO(148, 112, 18, 10),
            title: const Text('Industrial Attachement Programme'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          ),
           ListTile(
            leading: const Icon(Icons.person_add_rounded),
             iconColor: const Color.fromRGBO(148, 112, 18, 10),
            title: const Text('Assign Examiner'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add_rounded),
             iconColor: const Color.fromRGBO(148, 112, 18, 10),
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
           
          