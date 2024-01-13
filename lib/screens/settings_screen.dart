import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  void uploadTippsCSV() async {
    final CollectionReference tips =
        FirebaseFirestore.instance.collection("tips");

    final myData = await rootBundle.loadString("assets/tips.csv");

    await truncateCollection('tips');

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
      };

      tips.add(record);
    }
    print('TIPS CSV UPLOADED SUCCESSFULLY');
  }

  void uploadQuestionsCSV() async {
    final CollectionReference questions =
        FirebaseFirestore.instance.collection("questions");

    final myData = await rootBundle.loadString("assets/questions.csv");

    await truncateCollection('questions');

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
    print('QUESTIONS CSV UPLOADED SUCCESSFULLY');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          // Center(
          //   child: Text('Hier kommt noch mehr!'),
          // ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.upload),
              onPressed: uploadQuestionsCSV,
              label: Text("Upload questions CSV"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.upload),
              onPressed: uploadTippsCSV,
              label: Text("Upload tipps CSV"),
            ),
          ),
        ],
      ),
    );
  }
}
