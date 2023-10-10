import 'package:coordinator/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         alignment: Alignment.center,
        child: Column(
            // Vertically center the widget inside the column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Image.asset(
            "assets/images/iium.png",
            height: 120,
            width: 120,
            alignment: Alignment.center,
          ),
          const Text(
            'i-KICT',
            style: TextStyle(fontSize: 20),
          ),
          const Text(
            'Industrial Attachement Programme',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            child: const Text('Start'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
          ),
        ],
      ),
    ));
  }
}
