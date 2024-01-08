import 'package:coordinator/screens/googlebtn.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
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
                        color: Color.fromRGBO(0, 146, 143, 10),
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Futura'),
                  ),
                  const Text(
                    'Industrial Attachment Programme Coordinator Dashboard',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        //fontStyle: FontStyle.italic,
                        //fontWeight: FontWeight.w900,
                        fontFamily: 'Futura'),textAlign: TextAlign.center,
                  ),
                  
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(20),
            color: const Color.fromRGBO(0, 146, 143, 10),
            height: double.infinity,
            child: Center(
              child: (GoogleBtn()),
            ),
          ),
        ),
      ]),
    );
  }
}
