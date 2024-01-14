import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:file_picker/file_picker.dart';
import 'package:photo_view/photo_view.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  void uploadTippsCSV(BuildContext context) async {
    final CollectionReference tips =
        FirebaseFirestore.instance.collection("tips");

    try {
      // Use FilePicker to pick the file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        File file = File(filePath);

        // Read the file content
        String myData = await file.readAsString(encoding: utf8);

        // Your existing logic to truncate the collection
        await truncateCollection('tips');

        // Your existing logic to parse and upload CSV data
        List<List<dynamic>> data = getCsvTableFromData(myData);
        for (var i = 0; i < data.length; i++) {
          var record = {
            'number': data[i][0],
            'title': data[i][1],
            'goal': data[i][2],
            'tipp': data[i][3],
            'description': data[i][4],
            'image': data[i][5],
            'a': data[i][6],
            'b': data[i][7],
            'c1': data[i][8],
            'c2': data[i][9],
            'alltag': data[i][10],
            'bei_der_arbeit': data[i][11],
            'hilfe_holen': data[i][12],
            'kommunikation': data[i][13],
            'reisen': data[i][14],
            'unterhaltung': data[i][15],
            'unterwegs': data[i][16],
            'zu_hause': data[i][17],
            'sport': data[i][18],
          };

          tips.add(record);
        }
        showSnackBar(context, 'TIPS CSV UPLOADED SUCCESSFULLY');
      } else {
        showSnackBar(context, 'No file selected');
      }
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }

  void uploadQuestionsCSV(BuildContext context) async {
    final CollectionReference questions =
        FirebaseFirestore.instance.collection("questions");

    try {
      // Use FilePicker to pick the file
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        File file = File(filePath);

        // Read the file content
        String myData = await file.readAsString(encoding: utf8);

        // Your existing logic to truncate the collection
        await truncateCollection('questions');

        // Your existing logic to parse and upload CSV data
        List<List<dynamic>> data = getCsvTableFromData(myData);
        for (var i = 0; i < data.length; i++) {
          var record = {
            'number': data[i][0],
            'question': data[i][1],
            'phase': data[i][2],
            'answer_1': data[i][3],
            'answer_2': data[i][4],
            'answer_3': data[i][5],
            'answer_4': data[i][6],
            'answer_5': data[i][7],
          };

          questions.add(record);
        }
        showSnackBar(context, 'QUESTIONS CSV UPLOADED SUCCESSFULLY');
      } else {
        showSnackBar(context, 'No file selected');
      }
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> truncateCollection(String collectionName) async {
    // final instance = FirebaseFirestore.instance;
    // final batch = instance.batch();
    // var collection = instance.collection(collectionName);
    // var snapshots = await collection.get();
    // for (var doc in snapshots.docs) {
    //   batch.delete(doc.reference);
    // }
    // await batch.commit();
    var collection = FirebaseFirestore.instance.collection(collectionName);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  getCsvTableFromData(var myData) {
    List<List<dynamic>> csvTable =
        CsvToListConverter(fieldDelimiter: ';').convert(myData);

    return csvTable;
  }

  // void showExampleImage(BuildContext context, String category) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Beispielbild'),
  //         content: Image.asset('assets/$category.png'), // Pfad zum Beispielbild
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Schliessen'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showExampleImage(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            child: Container(
              color: Colors.black,
              child: PhotoView(
                imageProvider: AssetImage('assets/$category.png'),
                backgroundDecoration: BoxDecoration(color: Colors.black),
              ),
            ),
            onTap: () => Navigator.of(context)
                .pop(), // Schließen beim Tippen auf das Bild
          ),
        );
      },
    );
  }

  void showFullImage(BuildContext context, String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: PhotoView(
            imageProvider: AssetImage('assets/$category.png'),
            backgroundDecoration: BoxDecoration(color: Colors.black),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hochladen von Fragen im CSV-Format: (ohne Überschrift)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'Das Format der Fragen-CSV sollte wie folgt sein: Nummer, Frage, Phase, Antwort 1, Antwort 2, Antwort 3, Antwort 4, Antwort 5.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Weitere Hinweise zum Format der CSV-Dateien finden Sie hier.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () =>
                        showExampleImage(context, 'questionExample'),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.upload),
              onPressed: () => uploadQuestionsCSV(context),
              label: Text("Upload questions CSV"),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hochladen von Tipps im CSV-Format: (ohne Überschrift)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                'Das Format der Tipps-CSV sollte wie folgt sein: Nummer, Titel, Ziel, Tipp, Beschreibung, Bild, A, B, C1, C2, Alltag, Bei der Arbeit, Hilfe holen, Kommunikation, Reisen, Unterhaltung, Unterwegs, Zu Hause, Sport.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Weitere Hinweise zum Format der CSV-Dateien finden Sie hier.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info_outline),
                    onPressed: () => showExampleImage(context, 'tipExample'),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.upload),
              onPressed: () => uploadTippsCSV(context),
              label: Text("Upload tipps CSV"),
            ),
            // Weitere Widgets oder Elemente nach Bedarf
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Einstellungen'),
  //     ),
  //     body: Column(
  //       children: [
  //         SizedBox(
  //           height: 8,
  //         ),
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton.icon(
  //             icon: Icon(Icons.upload),
  //             onPressed: () => uploadQuestionsCSV(context),
  //             label: Text("Upload questions CSV"),
  //           ),
  //         ),
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton.icon(
  //             icon: Icon(Icons.upload),
  //             onPressed: () => uploadTippsCSV(context),
  //             label: Text("Upload tipps CSV"),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
