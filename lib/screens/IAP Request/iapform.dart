import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class IAPForm extends StatelessWidget {
  final String matric;
  final String name;
  final String email;
  final String major;
  final String admission;
  final String univ;
  final String department;
  final String kulliyyah;
  final String elective;
  final String ch;
  final String total;
  final String semester;
  final String confirmation;
  final String graduation;
  final String partial;

  const IAPForm({
    required this.matric,
    required this.name,
    required this.email,
    required this.major,
    required this.admission,
    required this.univ,
    required this.department,
    required this.kulliyyah,
    required this.elective,
    required this.ch,
    required this.total,
    required this.semester,
    required this.confirmation,
    required this.graduation,
    required this.partial,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student IAP Form - Matric No: $matric'),
      ),
      
      body: Container(
        padding: const EdgeInsets.all(20.0), // Example padding, adjust as needed
        child: ListView(
          children: [
            _buildListTile('Matric No', matric),
            _buildListTile('Student Name', name),
            _buildListTile('Email', email),
            _buildListTile('Major' ,major),
            _buildListTile('Admission Type' ,admission),
            _buildListTile('University Required Course', univ),
            _buildListTile('Department Required Course' , department),
            _buildListTile('Kulliyyah Required Course' , kulliyyah),
            _buildListTile('Department Elective Course' , elective),
            _buildListTile('CH Current Sem' , ch),
            _buildListTile('Total CH' ,total),
            _buildListTile('Semester' , semester),
            _buildListTile('Confirmation Letter' , confirmation),
            _buildListTile('Graduation Audit' , graduation),
            _buildListTile('Partial Transcript' , partial),
                  // Confirmation Letter
            _buildListTileWithPDFViewer('Confirmation Letter', confirmation),
            
            // Graduation Audit
            _buildListTileWithPDFViewer('Graduation Audit', graduation),
            
            // Partial Transcript
            _buildListTileWithPDFViewer('Partial Transcript', partial),
          ],
        ),
      ),
    );
  }

Widget _buildListTileWithPDFViewer(String label, String pdfUrl) {
    return FutureBuilder<String>(
      future: _getPDFUrlFromStorage(pdfUrl),
      builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.hasData) {          return ListTile(
            title: Text(
              label,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerPage(IAPForm: snapshot.data!),
                  ),
                );
              },
              child: const Text('View PDF'),
            ),
          );
        }
        } 
          return const CircularProgressIndicator();
        
      },
    );
  }

  Future<String> _getPDFUrlFromStorage(String IAPForm) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(IAPForm);
      final downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Failed to load PDF: $e'); // Log the error for debugging
      throw Exception('Failed to load PDF: $e');
    }
  }
}

class PDFViewerPage extends StatelessWidget {
  final String IAPForm;

  const PDFViewerPage({Key? key, required this.IAPForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        IAPForm,
        // Customize PDF viewer settings here if needed
      ),
    );
  }
}



Widget _buildListTile(String label, String data) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
    ),
    child: ListTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), 
               
              ],
            ),
          ),
          const VerticalDivider( 
            color: Colors.black,
            thickness: 1.0,
            width: 1, 
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data,
                  style: const TextStyle(fontSize: 16.0),
                ),

                
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget _buildListTileModified(String label, String data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
