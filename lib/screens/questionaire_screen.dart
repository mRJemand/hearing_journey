import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hearing_journey/widgets/querstionaire.dart';
import 'package:path_provider/path_provider.dart';

class QuestionaireScreen extends StatefulWidget {
  static const routeName = '/questionaire';

  @override
  State<QuestionaireScreen> createState() => _QuestionaireScreenState();
}

class _QuestionaireScreenState extends State<QuestionaireScreen> {
  bool? resultFirstQuestion;

  bool? resultSecondQuestion;

  firstQuestion(BuildContext context) {
    return AlertDialog(
      title: const Text('Nutzen Sie ein Hörgerät?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              resultFirstQuestion = true;
            });
            // Navigator.pop(context, 'Ja');
          },
          child: const Text('Ja'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              resultFirstQuestion = false;
            });
            // Navigator.pop(context, 'Nein');
          },
          child: const Text('Nein'),
        ),
      ],
    );
  }

  secondQuestion(BuildContext context) {
    return AlertDialog(
      title: const Text('Sind Sie zufrieden mit dem Hörgerät?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            _saveKennzahlen('C1');
            setState(() {
              resultSecondQuestion = true;
            });
            Navigator.pop(context, 'Ja');
          },
          child: const Text('Ja'),
        ),
        TextButton(
          onPressed: () {
            _saveKennzahlen('C2');
            setState(() {
              resultSecondQuestion = false;
            });
            Navigator.pop(context, 'Nein');
          },
          child: const Text('Nein'),
        ),
      ],
    );
  }

  Future<void> _saveKennzahlen(String kennzahlen) async {
    try {
      print('Kennzahlen: $kennzahlen');
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File kennzahlenFile = File('${appDocDir.path}/kennzahlen.json');
      print(appDocDir.path);
      Map<String, dynamic> data = {'highestCategory': kennzahlen};
      await kennzahlenFile.writeAsString(jsonEncode(data));
    } catch (e) {
      print('Error saving kennzahlen: $e');
    }
  }

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
        child: resultFirstQuestion == null && resultSecondQuestion == null
            ? firstQuestion(context)
            : resultFirstQuestion == true
                ? secondQuestion(context)
                : QuestionnaireWidget(),
      ),
    );
  }
}
