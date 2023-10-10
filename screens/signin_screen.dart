import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
   
        child: Column(
        
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
               Navigator.pop(context);
            },
          ),
        ],
      ),
    )
    );
  }
}