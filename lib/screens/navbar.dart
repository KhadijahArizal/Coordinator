import 'package:coordinator/screens/IAP%20Emergency/lisstudent6.dart';
import 'package:coordinator/screens/IAP%20Examiner/examiner.dart';
import 'package:coordinator/screens/IAP%20Examiner/liststudent5.dart';
import 'package:coordinator/screens/IAP%20Final%20Report/liststudent7.dart';
import 'package:coordinator/screens/IAP%20Monthly%20Report/liststudent9.dart';
import 'package:coordinator/screens/IAP%20Placement/liststudent3.dart';
import 'package:coordinator/screens/IAP%20Result/liststudent8.dart';
import 'package:coordinator/screens/IAP%20Supervisor/liststudent4.dart';
import 'package:coordinator/screens/IAP%20Request/liststudent1.dart';
import 'package:coordinator/screens/IAP%20Student%20Details/liststudent2.dart';
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
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 146, 143, 10),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/iium.png', // Replace with your image path
                  width: 40, // Set the width as needed
                  height: 40, // Set the height as needed
                  // Adjust other properties as needed for alignment, etc.
                ),
                const SizedBox(width: 10), const Text('i-KICT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Futura')),
        ]),
          ),
          const SizedBox(
            height: 10,
          ),
          /*ListTile(
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
          ),*/
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
          /*ListTile(
            leading: const Icon(Icons.app_registration_sharp),
            iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Industrial Attachment Programme'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => NavBar()))
            },
          ),*/
           ListTile(
            leading: const Icon(Icons.list_alt_outlined),
             iconColor: const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('IAP Form'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent1()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_document),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Student '),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>  const ListStudent2()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.place_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Placement '),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent3()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Supervisor '),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent4()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Assign Examiner'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>  const AssignExaminer()))
            },
          ),
           ListTile(
            leading: const Icon(Icons.people_alt_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Add Examiner'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AddExaminer()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.emergency_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Emergency Contact'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent6()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.description_rounded),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Monthly Report'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) =>  const ListStudent9()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.insert_drive_file_rounded),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Final Report'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent7()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_outlined),
             iconColor:const Color.fromRGBO(0, 146, 143, 10),
            title: const Text('Result'),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const ListStudent8()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
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
