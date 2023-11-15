import 'package:coordinator/screens/applications.dart';
import 'package:coordinator/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/dashboard.dart';
//import '../screens/applications.dart';
//import '../screens/placement.dart';
//import '../screens/coverletter.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false));

bool _visible = true;

class nav_bar extends StatelessWidget {
  const nav_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Material(
          color: Colors.white,
          child: Visibility(
              visible: _visible,
              child: ListView(children: <Widget>[
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
                buildMenuItem(
                    text: 'Dashboard',
                    icon: Icons.dashboard_rounded,
                    onClicked: (() => selectedItem(context, 0))),
                const SizedBox(
                  height: 10,
                ),
                buildMenuItem(
                    text: 'IAP Applications',
                    icon: Icons.app_registration_sharp,
                    onClicked: (() => selectedItem(context, 1))),
                const SizedBox(
                  height: 10,
                ),
                buildMenuItem(
                    text: 'Cover Letter Request',
                    icon: Icons.request_page,
                    onClicked: (() => selectedItem(context, 3))),
                const SizedBox(
                  height: 10,
                ),
                buildMenuItem(
                    text: 'Placement Verification',
                    icon: Icons.approval_sharp,
                    onClicked: (() =>
                        selectedItem(context, 2))), //_visible = false
                const SizedBox(
                  height: 10,
                ),
                buildMenuItem(
                    text: 'Internship Students',
                    icon: Icons.list_alt_sharp,
                    onClicked: (() => selectedItem(context, 4))),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Colors.black54,
                ),
                buildMenuItem(
                  text: 'Quit',
                  icon: Icons.exit_to_app_rounded,
                  onClicked: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Signin()));
                  },
                ),
              ]))),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    const hoverColor = Colors.white70;

    return ListTile(
        leading: Icon(
          icon,
          color: const Color.fromRGBO(148, 112, 18, 10),
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontFamily: 'Futura'),
        ),
        hoverColor: hoverColor,
        onTap: onClicked);
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => const Dashboard(
                    title: '',
                  )),
        );
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TabBars(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TabBars(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TabBars(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TabBars(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TabBars(),
        ));
        break;
    }
  }
}
