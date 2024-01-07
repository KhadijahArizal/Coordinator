import 'package:firebase_database/firebase_database.dart';

class FirebaseDataFetcher {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  Future<Map<String, int>> fetchStatusCounts() async {
    Map<String, int> statusCounts = {
      'Approved': 0,
      'Pending': 0,
      // Add more statuses if needed
    };

    try {
      DataSnapshot snapshot = await _databaseReference.child('Student').child('IAP Form').once().then((event) => event.snapshot);
      
      if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> students = snapshot.value as Map<dynamic, dynamic>;

        students.forEach((key, value) {
          if (value != null && value['Status'] != null) {
            String status = value['Status'];
            if (statusCounts.containsKey(status)) {
              statusCounts[status] = statusCounts[status]! + 1;
            } else {
              statusCounts[status] = 1;
            }
          }
        });
      }
    } catch (error) {
      print("Error fetching data: $error");
    }

    return statusCounts;
  }
}
