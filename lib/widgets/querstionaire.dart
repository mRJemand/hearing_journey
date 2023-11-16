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
  int currentQuestionIndex = 0;
  // List<Question> questions = DUMMY_QUESTIONS;
  Map<Question, int> selectedAnswers = {};
  Map<String, int> phasePoints = {};
  List<Question>? questionsList;
  // neu

  final CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  late QuerySnapshot? questionSnapshot;
  int currentIndex = 0;
  int? total;
  List<Question>? allQuestions;

  getLength() async {
    var getDocuments =
        await questions.where("register", isEqualTo: "yes").get();
    setState(() {
      total = getDocuments.docs.length;
    });
  }

  @override
  void initState() {
    super.initState();
    questions.get().then((snapshot) {
      if (snapshot != null) {
        setState(() {
          questionSnapshot = snapshot;
          getLength();
        });
      }
    });
  }

  void selectAnswer(Question question, int answer) {
    print("hallo $question $answer");
    setState(() {
      currentIndex++;
      selectedAnswers[question] = answer;
      selectedAnswers.forEach((question, answer) {
        print('${question.number}: ---> $answer');
      });
      if (currentIndex < allQuestions!.length) {
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
    if (questionSnapshot == null) {
      return Center(child: CircularProgressIndicator());
    }

    // var currentDocument = questionSnapshot!.docs[currentIndex] as Question;
    final currentDocumentData =
        questionSnapshot!.docs[currentIndex].data() as Map<String, dynamic>;
    final currentQuestion =
        Question.fromDocumentSnapshot(questionSnapshot!.docs[currentIndex]);

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
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('questions').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text(
                    'Loading...',
                    style: const TextStyle(color: Colors.red),
                  );
                default:
                  allQuestions = createQuestionList(snapshot.data!);
                  return SizedBox(
                      width: double.infinity,
                      child: QuestionWidget(
                        questionObject: currentQuestion,
                        selectAnswer: selectAnswer,
                      ));
              }
            },
          ),
        ),
      ),
    );
  }
}
