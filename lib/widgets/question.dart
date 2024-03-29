import 'package:flutter/material.dart';
import 'package:hearing_journey/models/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question questionObject;
  final Function selectAnswer;

  const QuestionWidget({
    required this.questionObject,
    required this.selectAnswer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: SizedBox(
        // Verwende SizedBox, um die Größe der Card anzupassen
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frage ${questionObject.number.toString()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),
              Text(
                questionObject.question,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Expanded(
                // Verwende Expanded, um die darunterliegende Column auszudehnen
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => selectAnswer(questionObject, 1),
                        child: Text(questionObject.answer_1),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 8)),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => selectAnswer(questionObject, 2),
                        child: Text(questionObject.answer_2),
                      ),
                    ),
                    questionObject.answer_3 != null
                        ? Padding(padding: EdgeInsets.only(top: 8))
                        : Container(),
                    questionObject.answer_3 != null
                        ? Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => selectAnswer(questionObject, 3),
                              child: Text(questionObject.answer_3!),
                            ),
                          )
                        : Container(),
                    questionObject.answer_4 != null
                        ? Padding(padding: EdgeInsets.only(top: 8))
                        : Container(),
                    questionObject.answer_4 != null
                        ? Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => selectAnswer(questionObject, 4),
                              child: Text(questionObject.answer_4!),
                            ),
                          )
                        : Container(),
                    questionObject.answer_5 != null
                        ? Padding(padding: EdgeInsets.only(top: 8))
                        : Container(),
                    questionObject.answer_5 != null
                        ? Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => selectAnswer(questionObject, 5),
                              child: Text(questionObject.answer_5!),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
