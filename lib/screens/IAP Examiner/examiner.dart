import 'package:coordinator/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddExaminer extends StatefulWidget {
  @override
  _AddExaminerState createState() => _AddExaminerState();
}

class _AddExaminerState extends State<AddExaminer> {
  String dropdownValue = 'Option 1';
  TextEditingController _newOptionController1 = TextEditingController();
  TextEditingController _newOptionController2 = TextEditingController();
  //DatabaseReference reference = FirebaseDatabase.instance.ref('Examiners').child('selectedNodes');
  List<String> dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  void _saveDataToFirebase(int optionNum, String newOption) {
    String selectedNode = 'Examiners';
    //String examType = ''; // Default node

    if (optionNum == 1) {
      selectedNode = 'BIT Examiners';
      //examType = 'BIT'; // Save for BIT Examiners
    } else if (optionNum == 2) {
      selectedNode = 'BCS Examiners';
      //examType = 'BCS'; // Save for BCS Examiners
    }

    DatabaseReference reference =
        FirebaseDatabase.instance.ref('Examiners').child(selectedNode);

    reference.push().set({
      'selectedOption': newOption,
      // Other data fields you want to save
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved to Firebase')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data: $error')),
      );
    });
  }

  void _addNewOption(int optionNum, TextEditingController controller) {
  String newOption = controller.text;
  if (newOption.isNotEmpty && !dropdownOptions.contains(newOption)) {
    setState(() {
      dropdownOptions.add(newOption);
      dropdownValue = newOption;
    });
    _saveDataToFirebase(optionNum, newOption); // Call _saveDataToFirebase here
    controller.clear();
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Examiner'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 146, 143, 10),
      ),
      drawer: NavBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'BIT Examiner',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Please add the BIT examiner'),
                ),
                SizedBox(height: 29.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'BCS Examiner',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Please add the BCS examiner'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.center, // Aligns columns to the center
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'BIT Examiner',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center, // Aligns rows to the center
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _newOptionController1,
                          decoration: const InputDecoration(
                            labelText: 'BIT Examiner - Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(children: [
                  Row(
                  children: [
                    const SizedBox(width: 16.0), // Creating space from the edge
                    ElevatedButton(
                     onPressed: () => _addNewOption(1, _newOptionController1), // Save data for BIT Examiners
                     style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 146, 143, 10),),
                      child: const Text('Save BIT Examiner', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0), // Adding space between elements
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'BCS Examiner',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _newOptionController2,
                          decoration: const InputDecoration(
                            labelText: 'BCS Examiner - Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 16.0), // Creating space from the edge
                    ElevatedButton(
                      onPressed: () => _addNewOption(2, _newOptionController2), // Save data for BCS Examiners
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 146, 143, 10),),
                      child: const Text('Save BCS Examiner', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                )]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
