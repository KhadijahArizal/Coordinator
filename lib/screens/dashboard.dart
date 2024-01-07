import 'package:coordinator/screens/firebase_data_fetch.dart';
import 'package:coordinator/screens/pie_chart_generator.dart';
import 'package:coordinator/screens/profilepage.dart';
import 'package:coordinator/screens/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final FirebaseDataFetcher dataFetcher = FirebaseDataFetcher();
  final PieChartGenerator chartGenerator = PieChartGenerator();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Coordinator Dashboard',
              style: TextStyle(
                color: Colors.black, // Change text color if needed
                fontSize: 18, // Adjust font size if needed
                fontWeight: FontWeight.normal, // Add fontWeight if needed
              ),
            ),
            SizedBox(width: 8), // Adjust the width as needed for spacing
          ],
        ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        GestureDetector(
                          onTap: () {
                            // Navigate to profile page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: user?.photoURL != null
                                ? NetworkImage(user!.photoURL!)
                                : null,
                            child: user?.photoURL == null
                                ? const Icon(
                                    Icons.account_circle,
                                    size: 30,
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
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
                  Column(
                    children: [
                      // Wrap each section in an Expanded widget to divide the available space evenly
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildChartSection(
                              'Student IAP Form Status',
                              dataFetcher.fetchStatusCounts(),
                            ),
                          ),
                          Expanded(
                            child: _buildChartSection2(
                              'Student Placement Status',
                              dataFetcher.fetchStatusCounts2(),
                            ),
                          ),
                          Expanded(
                            child: _buildChartSection3(
                              'Final Report Status',
                              dataFetcher.fetchStatusCounts3(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection(String title, Future<Map<String, int>> chartData) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          child: FutureBuilder<Map<String, int>>(
            future: chartData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                  child: chartGenerator.generatePieChart(snapshot.data ?? {}),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection2(String title, Future<Map<String, int>> chartData) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          child: FutureBuilder<Map<String, int>>(
            future: chartData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                  child: chartGenerator.generatePieChart2(snapshot.data ?? {}),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection3(String title, Future<Map<String, int>> chartData) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 200,
          child: FutureBuilder<Map<String, int>>(
            future: chartData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                  child: chartGenerator.generatePieChart3(snapshot.data ?? {}),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
