import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coordinator/screens/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.title});
  final String title;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _name({required String name}) => Container(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            )
          ],
        ),
      );

  Widget _coordinatorContact(
          {required String staffID, required String email}) =>
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              staffID,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const VerticalDivider(
                color: Colors.white,
                width: 10,
                thickness: 100,
                indent: 0,
                endIndent: 0),
            Text(
              email,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      );

  //bool _customTileExpanded = false;
  //bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: const IconThemeData(
              color: Color.fromRGBO(148, 112, 18, 1), size: 30)),
      drawer: const nav_bar(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: const AssetImage('assets/images/iium.png'),
            //fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white30.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 40,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Futura'),
                        ),
                        _name(name: 'Dr. Izzuddin'),
                      ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        "assets/images/profile.png",
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  boxShadow: const [
                    BoxShadow(color: Color.fromRGBO(148, 112, 18, 1))
                  ],
                  border: Border.all(
                      color: const Color.fromRGBO(148, 112, 18, 1), width: 7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _coordinatorContact(
                      email: 'izzuddin@live.iium.edu.my', staffID: 'IT101760'),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ]),
        ]),
      )),
    );
  }
}
