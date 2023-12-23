import 'package:coordinator/screens/auth.dart';
import 'package:coordinator/screens/dashboard.dart';
import 'package:flutter/material.dart';

class GoogleBtn extends StatefulWidget{
  @override
  _GoogleBtnState createState() => _GoogleBtnState();
}

class _GoogleBtnState extends State<GoogleBtn> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.teal),
          ),
          color: Colors.white
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ), 
            onPressed: () async {
              setState(() {
                _isProcessing = true;
              });
              await signInWIthGoogle().then((result) {
                print(result);
                if(result != null){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Dashboard(title: ''),
                      ),
                    );
                }
              }).catchError((error) {
                print('error $error');
              });
              setState(() {
                _isProcessing = false;
              });
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
          );
  }
}