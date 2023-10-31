import 'package:coordinator/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // Container for the text
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
              // Container for the button
              margin: const EdgeInsets.only(top: 20), // Add some spacing
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(148, 112, 18, 1),
                  side:
                      const BorderSide(color: Color.fromRGBO(148, 112, 18, 1)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signin()),
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
