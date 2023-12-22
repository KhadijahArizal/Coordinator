import 'package:coordinator/screens/signin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        color: Colors.teal,
                        fontSize: 35,
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Futura'),
                  ),
                  const Text(
                    'Industrial Attachment Programme Dashboard',
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
            Container(
              
              margin: const EdgeInsets.only(top: 20), 
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side:
                      const BorderSide(color:Colors.teal),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signin()),
                  );
                },
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}