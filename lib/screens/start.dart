import 'package:coordinator/screens/signin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/iium.png",
                  height: 200,
                  width: 200,
                  alignment: Alignment.center,
                ),
                const Text(
                  'i-KICT',
                  style: TextStyle(
                      color: Color.fromRGBO(148, 112, 18, 1),
                      fontSize: 35,
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Futura'),
                ),
                const Text(
                  'Industrial Attachment Programme Dashboard (Coordinator)',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      //fontStyle: FontStyle.italic,
                      //fontWeight: FontWeight.w900,
                      fontFamily: 'Futura'),
                ),
              ],
            ),
          ),
           const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    8.0), 
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signin()),
              );
            },
            child: const Text(
              'Start',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
