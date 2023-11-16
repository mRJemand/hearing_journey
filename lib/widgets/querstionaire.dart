import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/widgets/question.dart';

import '../dummy_data.dart';
import '../models/question.dart';
import '../screens/result_screen.dart';

class QuestionnaireWidget extends StatefulWidget {
  @override
  _QuestionnaireWidgetState createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  // List<Question> questions = DUMMY_QUESTIONS;
  Map<Question, int> selectedAnswers = {};
  Map<String, int> phasePoints = {};
  List<Question>? questionsList;
  // neu

  final CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  late QuerySnapshot? questionSnapshot;
  int currentQuestionIndex = 0;

  List<Question>? allQuestions;

  @override
  void initState() {
    super.initState();
    questionSnapshot = null;
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      QuerySnapshot snapshot = await questions.get();
      if (snapshot != null) {
        setState(() {
          questionSnapshot = snapshot;
          allQuestions = createQuestionList(snapshot);
          allQuestions?.sort((a, b) => a.number.compareTo(b.number));
        });
      }
    } catch (e) {
      print('Error loading questions: $e');
    }
  }

  void selectAnswer(Question question, int answer) {
    print("hallo $question $answer");
    setState(() {
      selectedAnswers[question] = answer;
      selectedAnswers.forEach((question, answer) {
        print('${question.number}: ---> $answer');
      });
      if (currentQuestionIndex < allQuestions!.length - 1) {
        currentQuestionIndex++;
      } else {
        // Der Fragebogen ist abgeschlossen, berechne die Punkte pro Kategorie
        for (var question in allQuestions!) {
          if (selectedAnswers.containsKey(question)) {
            var phase = question.phase;
            var points = selectedAnswers[question]!;
            phasePoints.putIfAbsent(phase,
                () => 0); // Kategorie hinzufügen, falls noch nicht vorhanden
            phasePoints[phase] =
                phasePoints[phase]! + points; // Punkte zur Kategorie addieren
          }
        }
        // Zeige den Ergebnis-Bildschirm an
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              categoryPoints: phasePoints,
              selectedAnswers: selectedAnswers,
            ),
          ),
        );
      }
    });
  }

  List<Question> createQuestionList(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((document) {
      return Question.fromDocumentSnapshot(document);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (questionSnapshot == null ||
        allQuestions == null ||
        questionSnapshot!.docs.length == 0 ||
        allQuestions!.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    final currentQuestion = allQuestions![currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fragebogen'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: QuestionWidget(
            questionObject: currentQuestion,
            selectAnswer: selectAnswer,
          ),
        ),
      ),
    );
  }
}
