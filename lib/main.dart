
import 'package:coordinator/screens/auth.dart';
import 'package:coordinator/screens/data.dart';
import 'package:coordinator/screens/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDW17txVZK6rztMZDkUbxdKm2dPg1RysCI",
        authDomain: "ikict-f49f6.firebaseapp.com",
        databaseURL: "https://ikict-f49f6-default-rtdb.firebaseio.com",
        projectId: "ikict-f49f6",
        storageBucket: "ikict-f49f6.appspot.com",
        messagingSenderId: "753383357173",
        appId: "1:753383357173:web:611c991c7dc7eb479fe3bc",
        measurementId: "G-2PD5H6E2C2"),
  );
  runApp( 
    ChangeNotifierProvider<Data>( // Wrap your MaterialApp with ChangeNotifierProvider
      create: (context) => Data(), // Replace Data() with your actual Data class instantiation
      child: MyApp(), // Your MyApp widget becomes the child
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
  }

  @override
  void initState() {
    getUserInfo();
    FirebaseMessaging.instance.getToken().then(print);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iKICT | Coordinator',
      theme: ThemeData(
        primaryColor: Colors.teal.shade900,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),

     
    );
  }
}

