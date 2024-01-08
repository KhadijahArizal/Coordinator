import 'package:coordinator/screens/signin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Column(
                  children: [
                    Image.asset(
                      "assets/images/iium.png",
                      height: 150,
                      width: 150,
                      alignment: Alignment.center,
                    ),
                    const Text(
                      'i-KICT',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 146, 143, 10),
                        fontSize: 55,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Futura',
                      ),
                    ),
                    const Text(
                      'Industrial Attachment Programme Coordinator Dashboard',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                        fontFamily: 'Futura',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),Container(
            width:400,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15), // Increase the button size
                backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
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
                  fontSize: 20.0, // Increase the text size
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
