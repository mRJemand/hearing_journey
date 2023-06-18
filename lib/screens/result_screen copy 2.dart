import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/question.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, int> categoryPoints;
  final Map<Question, int> selectedAnswers;

  ResultScreen({required this.categoryPoints, required this.selectedAnswers});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, int> categoryScores;
  late String highestCategory;
  late Map<String, double> categoryAverages;

  @override
  void initState() {
    super.initState();
    calculateResults();
  }

  void calculateResults() {
    int totalPoints =
        widget.selectedAnswers.values.reduce((sum, points) => sum + points);
    categoryScores = {};

    widget.selectedAnswers.forEach((question, answer) {
      var category = question.category;
      var points = answer;
      categoryScores.update(category, (value) => value + points,
          ifAbsent: () => points);
    });

    highestCategory = categoryScores.entries.reduce((a, b) {
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

    categoryAverages = {};

    widget.categoryPoints.forEach((category, points) {
      int selectedAnswersCount = categoryScores[category] ?? 0;
      double average = selectedAnswersCount != 0
          ? points / selectedAnswersCount.toDouble()
          : 0;
      categoryAverages[category] = average;
    });
  }

  Future<void> _saveKennzahlen(String kennzahlen) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File kennzahlenFile = File('${appDocDir.path}/kennzahlen.json');
    Map<String, dynamic> data = {'highestCategory': kennzahlen};
    await kennzahlenFile.writeAsString(jsonEncode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ergebnisse'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await _saveKennzahlen(highestCategory);
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
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ergebnisse',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              for (var entry in widget.selectedAnswers.entries)
                Text(
                  'Frage ${entry.key.id}: Antwort ${entry.value}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 16),
              Text(
                'Punkte pro Kategorie:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              for (var entry in categoryScores.entries)
                Text(
                  '${entry.key}: ${entry.value} Punkte',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 16),
              Text(
                'Mittelwert pro Kategorie:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              for (var entry in categoryAverages.entries)
                Text(
                  '${entry.key}: ${entry.value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              SizedBox(height: 16),
              Text(
                'Gesamtpunktzahl: ${widget.selectedAnswers.values.reduce((sum, points) => sum + points)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Kategorie mit höchstem Wert: $highestCategory',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
