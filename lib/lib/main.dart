import 'package:coordinator/router/routes.dart';
import 'package:coordinator/screens/coverletter.dart';
import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:coordinator/screens/tabsbar.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
  options: const FirebaseOptions(
  apiKey: "AIzaSyD_BTgtGN-h-eyHwag8kKULWp-fytl1I7Y",
  authDomain: "ikict-coordinator-2aac8.firebaseapp.com",
  projectId: "ikict-coordinator-2aac8",
  storageBucket: "ikict-coordinator-2aac8.appspot.com",
  messagingSenderId: "635630579330",
  appId: "1:635630579330:web:44c8d46db930bb77e34e9b",
  measurementId: "G-S9LRLQZGJR")
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: Routes.MyHomePage, // Set the initial route
      title: 'IAP Coordinator',
      debugShowCheckedModeBanner: false,
      home: Dashboard(title: ''),//Applications(title: 'title'),//AuthPage(), 
      //MyHomePage(),
    );
  }
}
