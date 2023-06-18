import 'package:flutter/material.dart';
import 'package:hearing_journey/widgets/querstionaire.dart';

class QuestionaireScreen extends StatelessWidget {
  static const routeName = '/questionaire';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade800,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: QuestionnaireWidget(),
      ),
    );
  }
}
