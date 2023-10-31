import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: <Widget>[
      Expanded(
        child: Container(
          // height: 450,
          // color: Colors.green,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/iium.png',
                  width: 150,
                  height: 150,
                ),
                const Text(
                  'i-KICT',
                  style: TextStyle(
                      color: Color.fromRGBO(148, 112, 18, 1),
                        fontSize: 25,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                      fontFamily: 'Futura'),
                ),
                const Text(
                  'Industrial Attachment Programme',
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
        ),
      ),
      Expanded(
        child: Container(
          color: const Color.fromRGBO(148, 112, 18, 1),
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/iium.png',
                  width: 100, // Adjust the width as needed
                ),
                const Text(
                  'i-KICT',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Futura'),
                ),
                const Text(
                  'Industrial Attachment Programme',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Futura'),
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}