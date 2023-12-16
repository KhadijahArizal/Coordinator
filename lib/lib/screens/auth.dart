import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const Dashboard(title: "");
            } else {
              return Signin();
            }
          }),
    );
  }
}
