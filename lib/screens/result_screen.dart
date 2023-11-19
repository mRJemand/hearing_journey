import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/home_screen.dart';
import 'package:hearing_journey/screens/tips_category_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/question.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, int> categoryPoints;
  final Map<Question, int> selectedAnswers;

  ResultScreen({required this.categoryPoints, required this.selectedAnswers});

  @override
  Widget build(BuildContext context) {
    int totalPoints =
        selectedAnswers.values.reduce((sum, points) => sum + points);
    Map<String, int> categoryScores = {};

    selectedAnswers.forEach((question, answer) {
      var category = question.phase;
      var points = answer;
      categoryScores.update(category, (value) => value + points,
          ifAbsent: () => points);
    });

    Future<void> _saveKennzahlen(String kennzahlen) async {
      if (kennzahlen == 'Precontemplation') {
        kennzahlen = 'a';
      } else if (kennzahlen == 'Contemplation' || kennzahlen == 'Action') {
        kennzahlen = 'b';
      }
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File kennzahlenFile = File('${appDocDir.path}/kennzahlen.json');
      Map<String, dynamic> data = {'highestCategory': kennzahlen};
      await kennzahlenFile.writeAsString(jsonEncode(data));
    }

    String highestCategory = categoryScores.entries.reduce((a, b) {
      if (a.value == b.value) {
        if (a.key == 'Action') {
          return a;
        } else if (a.key == 'Contemplation' &&
            b.key != 'Action' &&
            b.key != 'Precontemplation') {
          return a;
        } else if (a.key == 'Precontemplation' &&
            b.key != 'Action' &&
            b.key != 'Contemplation') {
          return a;
        } else {
          return b;
        }
      } else {
        return a.value > b.value ? a : b;
      }
    }).key;

    Map<String, double> categoryAverages = {};

    categoryScores.forEach((category, points) {
      int selectedAnswersCount = selectedAnswers.keys
          .where((question) => question.phase == category)
          .length;
      double average = selectedAnswersCount != 0
          ? points / selectedAnswersCount.toDouble()
          : 0.0;
      categoryAverages[category] = average;
    });

    String highestAverageCategory = categoryAverages.entries.reduce((a, b) {
      if (a.value == b.value) {
        if (a.key == 'Action') {
          return a;
        } else if (a.key == 'Contemplation' &&
            b.key != 'Action' &&
            b.key != 'Precontemplation') {
          return a;
        } else if (a.key == 'Precontemplation' &&
            b.key != 'Action' &&
            b.key != 'Contemplation') {
          return a;
        } else {
          return b;
        }
      } else {
        return a.value > b.value ? a : b;
      }
    }).key;

    Map<String, int> categoryQuestionCounts = {};

    selectedAnswers.keys.forEach((question) {
      var category = question.phase;
      categoryQuestionCounts.update(category, (value) => value + 1,
          ifAbsent: () => 1);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await _saveKennzahlen(highestAverageCategory);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Kennzahlen wurden gespeichert.'),
              ));
            },
          ),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[800]!,
                Colors.grey[900]!,
              ],
            ),
          ),
          child: AlertDialog(
            title: const Text('Vielen Dank für das ausfüllen des Fragebogens.'),
            content: const Text(
                'Sie können nun entweder zur Startseite oder direkt zu den Tipps'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await _saveKennzahlen(highestAverageCategory);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Kennzahlen wurden gespeichert.'),
                  ));
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                  // Navigator.pop(context, 'Ja');
                },
                child: const Text('Hauptmenü'),
              ),
              TextButton(
                onPressed: () async {
                  await _saveKennzahlen(highestAverageCategory);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Kennzahlen wurden gespeichert. ($highestAverageCategory)'),
                  ));
                  Navigator.of(context)
                      .pushReplacementNamed(TippsCategoryScreen.routeName);
                  // Navigator.pop(context, 'Nein');
                },
                child: const Text('Tipps'),
              ),
            ],
          )
          //   Container(
          //     width: double.infinity,
          //     padding: EdgeInsets.all(16.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Ergebnisse',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 16),
          //         for (var entry in selectedAnswers.entries)
          //           Text(
          //             'Frage ${entry.key.number}: Antwort ${entry.value}',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Punkte pro Kategorie:',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 8),
          //         for (var entry in categoryScores.entries)
          //           Text(
          //             '${entry.key}: ${entry.value} Punkte',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Mittelwert pro Kategorie:',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 8),
          //         for (var entry in categoryAverages.entries)
          //           Text(
          //             '${entry.key}: ${entry.value.toStringAsFixed(2)}',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Anzahl Fragen pro Kategorie:',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 8),
          //         for (var entry in categoryQuestionCounts.entries)
          //           Text(
          //             '${entry.key}: ${entry.value}',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Gesamtpunktzahl: $totalPoints',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(height: 16),
          //         Text(
          //           'Kategorie mit höchstem Mittelwert: $highestAverageCategory',
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          ),
    );
  }
}
