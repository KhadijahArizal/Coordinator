//import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class Signin extends StatelessWidget {
  final controller = Get.put(LoginController());
  Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
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
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(148, 112, 18, 1),
              height: double.infinity,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          controller.login();
                          //GoogleSignIn().signIn();
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard(
                                        title: '',
                                      )));*/
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Login with Gmail",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
