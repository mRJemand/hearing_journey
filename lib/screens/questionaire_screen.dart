import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/home_screen.dart';
import 'package:hearing_journey/screens/tips_category_screen.dart';
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
  bool? endDialog;

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
            _saveKennzahlen('c1');
            setState(() {
              resultSecondQuestion = true;
            });

            setState(() {
              endDialog = true;
            });
          },
          child: const Text('Ja'),
        ),
        TextButton(
          onPressed: () {
            _saveKennzahlen('c2');
            setState(() {
              resultSecondQuestion = false;
            });

            setState(() {
              endDialog = true;
            });
          },
          child: const Text('Nein'),
        ),
      ],
    );
  }

  endAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
          'Da Sie schon ein Hörgerät benützen, brauchen Sie nicht den Fragebogen auszufüllen'),
      content: const Text(
          'Sie können nun entweder zur Startseite oder direkt zu den Tipps'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
          child: const Text('Hauptmenü'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(TippsCategoryScreen.routeName);
          },
          child: const Text('Tipps'),
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
        child: endDialog == true
            ? endAlertDialog(context)
            : resultFirstQuestion == null && resultSecondQuestion == null
                ? firstQuestion(context)
                : resultFirstQuestion == true
                    ? secondQuestion(context)
                    : QuestionnaireWidget(),
      ),
    );
  }
}
