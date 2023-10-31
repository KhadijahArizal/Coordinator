import 'package:coordinator/router/routes.dart';
//import 'package:coordinator/screens/applications.dart';
//import 'package:coordinator/screens/dashboard.dart';
import 'package:coordinator/screens/home_screen.dart';
import 'package:coordinator/screens/signin_screen.dart';
//import 'package:coordinator/screens/signin_screen.dart';
//import 'package:coordinator/screens/signin_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Signin(),//tukar route dkt sini
        title: 'IAP Coordinator',
        debugShowCheckedModeBanner: false,
       
        routes: {
          /*Routes.orderForm: (context) => const orderForm(),
          Routes.orderDetail: (context) => const OrderDetail(),
          Routes.profile: (context) => const UserProfile(),
          Routes.location: (context) => const Location(),
          Routes.contactUs: (context) => const contactUs(),
          Routes.paymentOption: (context) => const PaymentOption(),
          Routes.codOption: (context) => const CodOption(),
          Routes.transferOption: (context) => const TransferOption(),*/
          Routes.homeScreen: (context) => const MyHomePage()
        });
  }
}