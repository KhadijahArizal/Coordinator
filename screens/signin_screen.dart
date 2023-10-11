import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(


      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            height: double.infinity,
          
          child: Image.asset(
            "assets/images/iium.png",
            height: 120,
            width: 120,
            alignment: Alignment.center,
          ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.amber,
            height: double.infinity,
          ),
        ),
      ]);
    
  }
}
