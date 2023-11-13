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
  Map<String, int> categoryPoints = {};
  // neu

  final CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  late QuerySnapshot questionSnapshot;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    questions.get().then((snapshot) {
      setState(() {
        questionSnapshot = snapshot;
      });
    });
  }

  void selectAnswer(int answer) {
    setState(() {
      // selectedAnswers[questions[currentQuestionIndex]] = answer;
      // if (currentQuestionIndex < questions.length - 1) {
      //   currentQuestionIndex++;
      // } else {
      //   // Der Fragebogen ist abgeschlossen, berechne die Punkte pro Kategorie
      //   for (var question in questions) {
      //     if (selectedAnswers.containsKey(question)) {
      //       var category = question.category;
      //       var points = selectedAnswers[question]!;
      //       categoryPoints.putIfAbsent(category,
      //           () => 0); // Kategorie hinzufügen, falls noch nicht vorhanden
      //       categoryPoints[category] = categoryPoints[category]! +
      //           points; // Punkte zur Kategorie addieren
      //     }
      //   }
      //   // Zeige den Ergebnis-Bildschirm an
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ResultScreen(
      //         categoryPoints: categoryPoints,
      //         selectedAnswers: selectedAnswers,
      //       ),
      //     ),
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questionSnapshot == null) {
      return Center(child: CircularProgressIndicator());
    }

    final currentDocument = questionSnapshot.docs[currentIndex];

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
              StreamBuilder<QuerySnapshot>(
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
                  // return Container(
                  //   height: 800,
                  //   child: ListView(
                  //     children:
                  //         snapshot.data!.docs.map((DocumentSnapshot document) {
                  //       return QuestionWidget(questionObject: document);
                  //     }).toList(),
                  //   ),
                  // );
                  // documentMap
                  //     .clear(); // Löschen Sie die vorherigen Einträge in der Map.
                  // for (var document in snapshot.data!.docs) {
                  //   documentMap[document.id] = document;
                  // }
                  // return QuestionWidget(
                  //     questionObject: documentMap[document.id]);
                  return SizedBox(
                      width: double.infinity,
                      child: QuestionWidget(questionObject: currentDocument));
              }
            },
          ),
        ),
      ),
    );
  }
}
