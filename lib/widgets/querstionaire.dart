import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/question.dart';
import '../screens/result_screen.dart';

class QuestionnaireWidget extends StatefulWidget {
  @override
  _QuestionnaireWidgetState createState() => _QuestionnaireWidgetState();
}

class _QuestionnaireWidgetState extends State<QuestionnaireWidget> {
  int currentQuestionIndex = 0;
  List<Question> questions = DUMMY_QUESTIONS;
  Map<Question, int> selectedAnswers = {};
  Map<String, int> categoryPoints = {};

  void selectAnswer(int answer) {
    setState(() {
      selectedAnswers[questions[currentQuestionIndex]] = answer;
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Der Fragebogen ist abgeschlossen, berechne die Punkte pro Kategorie
        for (var question in questions) {
          if (selectedAnswers.containsKey(question)) {
            var category = question.category;
            var points = selectedAnswers[question]!;
            categoryPoints.putIfAbsent(category,
                () => 0); // Kategorie hinzufügen, falls noch nicht vorhanden
            categoryPoints[category] = categoryPoints[category]! +
                points; // Punkte zur Kategorie addieren
          }
        }
        // Zeige den Ergebnis-Bildschirm an
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              categoryPoints: categoryPoints,
              selectedAnswers: selectedAnswers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child:
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [

              //   ],
              // ),
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('questions')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return Container(
                        height: 800,
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 8.0,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Frage ${document['number'].toString()}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(height: 16),
                                    Text(
                                      document['question'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 16),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: AnswerButton(
                                            answer: 0,
                                            isSelected: selectedAnswers[
                                                    questions[
                                                        currentQuestionIndex]] ==
                                                0,
                                            onSelect: selectAnswer,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: AnswerButton(
                                            answer: 1,
                                            isSelected: selectedAnswers[
                                                    questions[
                                                        currentQuestionIndex]] ==
                                                1,
                                            onSelect: selectAnswer,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: AnswerButton(
                                            answer: 2,
                                            isSelected: selectedAnswers[
                                                    questions[
                                                        currentQuestionIndex]] ==
                                                2,
                                            onSelect: selectAnswer,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: AnswerButton(
                                            answer: 3,
                                            isSelected: selectedAnswers[
                                                    questions[
                                                        currentQuestionIndex]] ==
                                                3,
                                            onSelect: selectAnswer,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: AnswerButton(
                                            answer: 4,
                                            isSelected: selectedAnswers[
                                                    questions[
                                                        currentQuestionIndex]] ==
                                                4,
                                            onSelect: selectAnswer,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final int answer;
  final bool isSelected;
  final Function(int) onSelect;

  AnswerButton(
      {required this.answer, required this.isSelected, required this.onSelect});

  String answerText() {
    if (answer == 0) {
      return 'Trifft überhaupt nicht zu';
    } else if (answer == 1) {
      return 'Trifft eher nicht zu';
    } else if (answer == 2) {
      return 'Weiss nicht';
    } else if (answer == 3) {
      return 'Trifft eher zu';
    } else if (answer == 4) {
      return 'Trifft voll und ganz zu';
    } else {
      return answer.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String answerOption = answerText();
    return ElevatedButton(
      onPressed: () {
        onSelect(answer);
      },
      style: ButtonStyle(
        backgroundColor:
            isSelected ? MaterialStateProperty.all<Color>(Colors.blue) : null,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      child: Text(
        '$answerOption',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
