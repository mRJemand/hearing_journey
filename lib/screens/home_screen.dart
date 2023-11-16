import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hearing_journey/screens/questionaire_screen.dart';
import 'package:hearing_journey/screens/tipps_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  final List<Map<String, dynamic>> items = [
    {
      'name': 'Fragebogen',
      'bild_url': 'fragebogen.jpg',
      'routeName': QuestionaireScreen.routeName,
    },
    {
      'name': 'Tipps',
      'bild_url': 'tipps.jpg',
      'routeName': TippsScreen.routeName
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        separatorBuilder: (context, index) =>
            SizedBox(height: 8), // Separation between cards
        itemBuilder: (context, index) {
          final Map<String, dynamic> item =
              items[index]; // greift auf das erste Element in der Liste zu

          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(item['routeName']);
            },
            child: Card(
              color: Colors.teal[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Image.asset(
                          'assets/${item['bild_url']}',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                          width: 350,
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
