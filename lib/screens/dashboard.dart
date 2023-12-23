import 'package:coordinator/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coordinator/screens/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      
      backgroundColor: const Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(
          color: Colors.teal,
          size: 30,
        ),
      ),
      drawer: NavBar(),
      body: SafeArea(
        child: Container(
          
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: const AssetImage('assets/images/iium.png'),
              colorFilter: ColorFilter.mode(
                Colors.white30.withOpacity(0.2),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Futura',
                          ),
                        ),
                        if (user != null)
                          Text(
                            user.displayName ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: imageUrl != null
                          ?NetworkImage(imageUrl!)
                          :null,
                          child: imageUrl == null
                          ? const Icon(
                            Icons.account_circle,
                            size: 30,
                          )
                          :Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      boxShadow: const [
                        BoxShadow(color: Color.fromRGBO(0, 146, 143, 10)),
                      ],
                      border: Border.all(
                        color: const Color.fromRGBO(0, 146, 143, 10),
                        width: 7,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (user != null)
                          Text(
                            user.email ?? '', // Display user's email
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                 
              const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}

